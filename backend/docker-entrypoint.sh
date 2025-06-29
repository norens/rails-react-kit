#!/bin/bash
set -e

echo "🔄 Generating Swagger docs..."
bundle exec rake rswag:specs:swaggerize || echo "⚠️ Swagger generation failed"

exec "$@"
