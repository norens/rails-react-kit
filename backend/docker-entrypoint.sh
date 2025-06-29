#!/bin/bash
set -e

echo "🔄 Generating Swagger docs..."
bundle exec rake rswag:specs:swaggerize || echo "⚠️ Swagger generation failed"

rm -rf tmp/pids/server.pid

exec "$@"
