# frozen_string_literal: true

return if ENV['PROMETHEUS_EXPORTER_DISABLED'] == 'true'

require 'prometheus_exporter/middleware'
Rails.application.middleware.unshift PrometheusExporter::Middleware
