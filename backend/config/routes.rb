# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get 'up' => 'rails/health#show', as: :rails_health_check
  get '/health', to: proc { [200, { 'Content-Type' => 'text/plain' }, ['OK']] }

  namespace :health do
    get :ping
  end

  namespace :api do
    get 'hello', to: 'hello#index'
  end
end
