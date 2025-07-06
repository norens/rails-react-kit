# 📈 Observability Setup Guide for Koala Stack

This guide explains how to enable full monitoring and observability for your microservice-based application using **Prometheus** and **Grafana**.

---

## ✅ What's included

### Dashboards (Grafana)
- Kafka Lag Monitoring
- Redis Stats
- Node Exporter (CPU, RAM, Disk)
- Docker Containers Metrics
- PostgreSQL DB Stats
- Rails HTTP Performance
- Sidekiq Background Jobs
- Traefik Gateway Stats

### Metrics Collection (Prometheus)
- `redis-exporter` (9121)
- `postgres-exporter` (9187)
- `sidekiq-exporter` (9292)
- `node-exporter` (9100)
- `kafka-exporter` (9308)
- `cadvisor` (8082) for Docker
- `rails` via `/metrics` (9394)
- `traefik` metrics via port 8080

---

## 🚀 Getting Started

### 1. Clone & setup dashboards

Make sure you extracted and placed all dashboard files into:

```
./docker/grafana/dashboards/
```

Then provision them via:

```bash
docker exec -it grafana /init.sh
```

---

### 2. Add Prometheus config

Ensure `./docker/prometheus.yml` contains all necessary `scrape_configs`:

```yaml
- job_name: 'rails'
  static_configs:
    - targets: ['backend:9394']
```

Add all exporters accordingly (see full prometheus.yml).

---

### 3. Use Docker Compose override

Apply enhanced exporters setup:

```bash
docker-compose -f docker-compose.yml -f docker-compose.override.yml up --build
```

---

### 4. Expose metrics from Rails

In your Rails app:

**Gemfile:**
```ruby
gem 'prometheus_exporter'
```

**config/application.rb:**
```ruby
require 'prometheus_exporter/middleware'
config.middleware.use PrometheusExporter::Middleware
```

**Startup command:**
```bash
bundle exec prometheus_exporter -b 0.0.0.0 -p 9394 &
```

---

## 📍 Final Notes

- Grafana: http://localhost:3001
- Prometheus: http://localhost:9090
- Default Grafana login: `admin` / `admin`

Enjoy full observability with zero guesswork 🐨🚀