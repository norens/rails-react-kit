Rails.application.config.after_initialize do
  at_exit do
    Rails.logger.info("[KafkaLogger] Flushing and retrying...")

    kafka = Kafka.new(["kafka:9092"], client_id: "rails-exit")
    producer = kafka.producer

    retry_file = Rails.root.join("tmp/kafka_retry.log")
    if File.exist?(retry_file)
      lines = File.readlines(retry_file).map(&:strip)
      lines.each do |line|
        begin
          producer.produce(line, topic: "logs")
        rescue => e
          Rails.logger.error("[KafkaRetry] Still failed: #{e.message}")
        end
      end
      File.delete(retry_file)
    end

    producer.deliver_messages
    producer.shutdown
  end
end
