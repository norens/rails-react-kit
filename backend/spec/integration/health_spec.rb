# frozen_string_literal: true
# rubocop:disable all

require 'swagger_helper'

RSpec.describe 'Health Check', type: :request do
  path '/health' do
    get 'ping health' do
      tags ['Health']
      produces 'application/json'

      response '200', 'successful' do
        # avoid Authorization bug
        let(:Authorization) { nil }

        run_test!
      end
    end
  end
end