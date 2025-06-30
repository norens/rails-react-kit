# frozen_string_literal: true

require 'json'
require 'kafka'

class KafkaLoggerMiddleware
  RETRY_FILE = Rails.root.join('tmp/kafka_retry.log')
  TOPIC = 'logs'

  def initialize(app)
    @app = app
    @kafka = Kafka.new(['kafka:9092'], client_id: 'rails-middleware')
    @producer = @kafka.async_producer(delivery_interval: 1, max_buffer_size: 100)
  end

  def call(env)
    started_at = Time.zone.now
    status, headers, response = @app.call(env)
    duration = calculate_duration(started_at)
    payload = build_payload(env, status, duration)
    log(payload)
    [status, headers, response]
  rescue StandardError => e
    Rails.logger.error("[KafkaLoggerMiddleware] Middleware error: #{e.message}")
    raise
  end

  def log(data)
    json = JSON.dump(data)
    @producer.produce(json, topic: TOPIC)
  rescue Kafka::Error
    Rails.logger.warn('[KafkaLoggerMiddleware] Kafka unavailable, retrying later.')
    File.open(RETRY_FILE, 'a') { |f| f.puts(json) }
  end

  private

  def calculate_duration(started_at)
    ((Time.zone.now - started_at) * 1000).round(1)
  end

  def build_payload(env, status, duration)
    request = Rack::Request.new(env)
    {
      timestamp: Time.now.utc.iso8601,
      method: request.request_method,
      path: request.fullpath,
      status: status,
      duration_ms: duration,
      ip: request.ip
    }
  end
end
