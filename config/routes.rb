# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  ActiveAdmin.routes(self)
  root to: 'pages#index'

  resources :projects, only: [:index, :show]
  resources :orders, only: [:index, :show]

  # Cart
  get '/add_to_cart/:id', to: 'orders#add_to_cart', as: 'add_to_cart'
  get '/cart', to: 'orders#cart', as: 'cart'
  get '/remove_from_cart/:id', to: 'orders#remove_from_cart', as: 'remove_from_cart'
  get '/my_orders', to: 'users/profile#my_orders', as: 'my_orders'

  # Callbacks
  post '/callbacks/yandex_money', to: 'callbacks/yandex_money#perform'

  # Static Pages
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'donate_policy', to: 'pages#donate_policy'

  # Feedback
  resources :feedbacks, only: [:new, :create]
end
