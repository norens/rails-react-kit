# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins do |origin, _env|
      allowed_origins = ENV.fetch('FRONTEND_URL', '').split(',')
      allowed_origins.include?(origin) ? origin : nil
    end

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: true
  end
end
