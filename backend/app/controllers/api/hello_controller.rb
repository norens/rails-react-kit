# frozen_string_literal: true

module Api
  class HelloController < ApplicationController
    def index
      render json: { message: 'Hello from backend!' }
    end
  end
end
