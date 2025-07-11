ENV_FILE ?= development

# 🐘 Docker
up:
	docker-compose -f docker-compose.yml -f docker-compose.observability.yml --env-file .env.$(ENV_FILE) up --build

dev:
	docker-compose --env-file .env.$(ENV_FILE) up --build

down:
	docker-compose down -v

restart:
	docker-compose down -v && docker-compose up --build --env-file .env.$(ENV_FILE)

logs:
	docker-compose logs -f --tail=100 --env-file .env.$(ENV_FILE)

ps:
	docker-compose ps --env-file .env.$(ENV_FILE)

# 🛠️ Backend
console:
	docker-compose exec backend rails console

dbconsole:
	docker-compose exec backend rails dbconsole

migrate:
	docker-compose exec backend rails db:migrate

seed:
	docker-compose exec backend rails db:seed

reset-db:
	docker-compose exec backend rails db:drop db:create db:migrate db:seed

rspec:
	docker-compose exec backend bundle exec rspec

rubocop:
	docker-compose exec backend bundle exec rubocop

rubocop-fix:
	docker-compose exec backend bundle exec rubocop -A

# 🧪 Swagger
swagger:
	docker-compose exec backend rake rswag:specs:swaggerize

# 🧾 Redis queue retry (if needed)
retry:
	docker-compose exec backend rake kafka:retry_queue

# 🧼 Utilities
build:
	docker-compose build

prune:
	docker system prune -af

brakeman:
	docker-compose run --rm backend bundle exec brakeman

lint:
	docker-compose run --rm backend bundle exec erb_lint --lint-all

# 💡 Help
help:
	@echo "🛠️  Makefile Commands:"
	@echo ""
	@echo "  up             - Run all containers"
	@echo "  dev            - Run all containers with development environment"
	@echo "  down           - Stop and remove all containers and volumes"
	@echo "  restart        - Restart all containers with fresh build"
	@echo "  logs           - Tail logs from all containers"
	@echo "  ps             - Show container statuses"
	@echo ""
	@echo "  console        - Rails console"
	@echo "  dbconsole      - Rails DB console"
	@echo "  migrate        - Run DB migrations"
	@echo "  seed           - Run seeds"
	@echo "  reset-db       - Drop, create, migrate, seed DB"
	@echo ""
	@echo "  rspec          - Run backend tests"
	@echo "  rubocop        - Run RuboCop linter"
	@echo "  rubocop-fix    - Auto-fix RuboCop offenses"
	@echo "  brakeman       - Run Brakeman security scanner"
	@echo "  lint           - Run ERB lint"
	@echo ""
	@echo "  swagger        - Generate Swagger docs"
	@echo "  retry          - Run Kafka retry queue (manual)"
	@echo ""
	@echo "  build          - Rebuild all images"
	@echo "  prune          - Remove all unused Docker data"
