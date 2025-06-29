# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Koala API',
        version: 'v1',
        description: 'This is the API documentation for the Koala project.',
        contact: {
          name: 'Koala Dev Team',
          email: 'support@koala.app'
        }
      },
      servers: [
        {
          url: ENV.fetch('API_DOCS_URL', 'http://localhost:3000'),
          description: 'Local dev server'
        }
      ],
      components: {
        securitySchemes: {
          BearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: :JWT
          }
        }
      },
      security: [
        {
          BearerAuth: []
        }
      ],
      paths: {}
    }
  }

  config.openapi_format = :yaml
end
