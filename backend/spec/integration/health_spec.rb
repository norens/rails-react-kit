# frozen_string_literal: true
# rubocop:disable all

require 'swagger_helper'

RSpec.describe 'Health Check', type: :request do
  path '/health/ping' do
    get('ping health') do
      tags 'Health'
      produces 'application/json'

      response(200, 'successful') do
        run_test!
      end
    end
  end
end
