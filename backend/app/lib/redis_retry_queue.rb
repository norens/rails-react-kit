# frozen_string_literal: true

require 'redis'
require 'json'

class RedisRetryQueue
  RETRY_QUEUE_KEY = 'kafka:retry_queue'

  def self.enqueue(payload)
    redis.rpush(RETRY_QUEUE_KEY, payload.to_json)
  end

  def self.dequeue
    json = redis.lpop(RETRY_QUEUE_KEY)
    JSON.parse(json) if json
  end

  def self.length
    redis.llen(RETRY_QUEUE_KEY)
  end

  def self.redis
    @redis ||= Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0'))
  end
end
