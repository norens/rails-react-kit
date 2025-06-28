# 🐨 Koala Platform

A modern monorepo boilerplate built for scalable fullstack applications.  
This project combines **Ruby on Rails**, **React + TypeScript**, **Kafka**, **Redis**, and **PostgreSQL**, with support for **Docker**, **CI/CD**, and **microservices**.

> 🗓️ Last updated: 2025-06-28

---

## 🔧 Tech Stack

| Layer       | Tech                     |
|-------------|--------------------------|
| Backend     | Ruby on Rails 7 (API-only) |
| Frontend    | React + TypeScript (Vite) |
| Messaging   | Kafka (Bitnami, PLAINTEXT) |
| Cache       | Redis                    |
| Database    | PostgreSQL 15            |
| Log Service | Node.js + KafkaJS        |
| Orchestration | Docker Compose         |
| Gateway     | Traefik (planned)        |
| CI/CD       | GitHub Actions (planned) |

---

## 📦 Folder Structure

```
├── apps/
│   ├── backend/        # Ruby on Rails app
│   ├── frontend/       # React app (Vite)
│   └── log-service/    # Node.js service for Kafka logs
├── docker/             # Configs for nginx, traefik etc.
├── .env, .env.\*        # Environment files
├── docker-compose.yml
└── README.md

````


## 🚀 Getting Started (Development)

```bash
# Clone the repo
git clone https://github.com/yourusername/koala-platform.git
cd koala-platform

# Start all services
docker-compose up --build
````

Local URLs:

* Backend: [http://localhost:3000](http://localhost:3000)
* Frontend: [http://localhost:4173](http://localhost:4173)

---

## ✅ Implemented

* [x] Rails + React monorepo via Docker
* [x] Kafka setup (Bitnami image, PLAINTEXT)
* [x] Kafka log producer from Rails
* [x] Node.js log service consumer
* [x] Retry logic for Kafka producer
* [x] Middleware logging all HTTP requests
* [x] Graceful shutdown on SIGTERM

---

## 🛠 TODO

### 🔐 Auth

* [ ] Add JWT/Auth0 authentication
* [ ] Protect APIs and emit login/signup events

### 🧪 Tests

* [ ] Unit + integration tests
* [ ] Kafka mock layer for test env

### 🌐 API Docs

* [ ] Swagger/OpenAPI via rswag

### 📊 Observability

* [ ] JSON logs with metadata
* [ ] Kafka → S3 or Elastic (optional)

### 🚢 DevOps

* [ ] GitHub Actions CI/CD
* [ ] Traefik reverse proxy + HTTPS (Let's Encrypt)
* [ ] `.env.production` and deploy scripts

---

## 📝 License

MIT © 2025 Koala Contributors
