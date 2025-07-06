#!/bin/bash
set -e

echo "🔄 Generating Swagger docs..."
bundle exec rake rswag:specs:swaggerize || echo "⚠️ Swagger generation failed"

if [ "$PROMETHEUS_EXPORTER_DISABLED" != "true" ]; then
  echo "📈 Starting prometheus_exporter on port 9394"
  bundle exec prometheus_exporter -b 0.0.0.0 -p 9394 &
fi

rm -rf tmp/pids/server.pid

exec "$@"
