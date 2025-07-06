const express = require('express');
const { Kafka } = require('kafkajs');
const client = require('prom-client');

const app = express();
const register = new client.Registry();

// Додай стандартні метрики Node.js (CPU, памʼять тощо)
client.collectDefaultMetrics({ register });

// Користувацька метрика: кількість повідомлень Kafka
const kafkaMessagesCounter = new client.Counter({
  name: 'kafka_messages_consumed_total',
  help: 'Total number of Kafka messages consumed by log-service',
});
register.registerMetric(kafkaMessagesCounter);

// ENDPOINT для Prometheus
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

app.listen(9100, () => {
  console.log('[Metrics] Server listening on http://localhost:9100/metrics');
});

// Kafka consumer
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

      // 🔥 Лічильник Kafka повідомлень
      kafkaMessagesCounter.inc();

      // TODO: збереження в базу або обробка
    },
  });
};

run().catch(e => {
  console.error('[Kafka] Consumer error:', e);
  process.exit(1);
});
