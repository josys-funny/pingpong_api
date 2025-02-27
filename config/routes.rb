# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, defaults: { format: :json }, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :matches, defaults: { format: :json }, controllers: {
    sessions: 'admins/sessions'
  }
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :users do
    resources :matches, only: [:index]
  end
  resources :matches, only: %i[show create update destroy]

  get 'api_docs' => 'api_docs#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
