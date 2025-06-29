namespace :kafka do
  desc "Flush retry queue to Kafka"
  task retry_logs: :environment do
    puts "[KafkaLogger] Retrying failed logs..."
    KafkaLogger.deliver_retry_queue
  end
end
