Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :health do
    get :ping
  end

  namespace :api do
    get 'hello', to: 'hello#index'
  end
end
