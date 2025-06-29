# frozen_string_literal: true

require "kafka"
require "singleton"
require "json"

class KafkaLogger
  include Singleton

  DEFAULT_TOPIC = "logs"

  def initialize
    kafka_brokers = ENV.fetch("KAFKA_BROKER", "kafka:9092").split(",")

    @kafka = Kafka.new(kafka_brokers, client_id: "koala-app")

    @producer = @kafka.async_producer(
      delivery_interval: 5, # flush every 5s
      max_retries: 3,
      required_acks: :all
    )

    @default_topic = DEFAULT_TOPIC
  rescue => e
    Rails.logger.error("[KafkaLogger::InitError] #{e.class}: #{e.message}")
    @producer = nil
  end

  def log(event_name:, payload:, topic: nil)
    message = {
      timestamp: Time.now.utc.iso8601,
      event: event_name,
      payload: payload
    }

    topic_name = topic || @default_topic

    if @producer
      @producer.produce(message.to_json, topic: topic_name)
    else
      RedisRetryQueue.enqueue(topic: topic_name, payload: message)
    end
  rescue => e
    Rails.logger.warn("[KafkaLogger::LogError] #{e.class}: #{e.message}")
    RedisRetryQueue.new.enqueue(message.merge(topic: topic_name))
  end

  def shutdown
    @producer&.shutdown
  end

  def self.deliver_retry_queue
    kafka_brokers = ENV.fetch("KAFKA_BROKER", "kafka:9092").split(",")
    kafka = Kafka.new(kafka_brokers, client_id: "koala-app-retry")
    producer = kafka.producer

    while (job = RedisRetryQueue.dequeue)
      begin
        producer.produce(job[:payload].to_json, topic: job[:topic])
      rescue => e
        Rails.logger.error("[KafkaLogger::RetryError] #{e.class}: #{e.message}")
        RedisRetryQueue.enqueue(**job)
        break
      end
    end

    producer.deliver_messages
  rescue => e
    Rails.logger.error("[KafkaLogger::RetryFlushError] #{e.class}: #{e.message}")
  end
end
