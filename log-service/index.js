const { Kafka } = require('kafkajs');

const kafka = new Kafka({
  clientId: 'log-service',
  brokers: [process.env.KAFKA_BROKER || 'kafka:9092'],
});

const consumer = kafka.consumer({ groupId: 'log-service-group' });

const run = async () => {
  await consumer.connect();
  await consumer.subscribe({ topic: 'logs', fromBeginning: false });

  console.log('[Kafka] Log service started and listening to "logs" topic...');

  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      const value = message.value.toString();
      console.log(`[Kafka][${topic}] ${value}`);

      // TODO: тут можна додати збереження в БД або файли
    },
  });
};

run().catch(e => {
  console.error('[Kafka] Consumer error:', e);
  process.exit(1);
});
