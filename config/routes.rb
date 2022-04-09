# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: 'localhost'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  ActiveAdmin.routes(self)
  root to: 'pages#index'
  get 'privacy_policy', to: 'pages#privacy_policy'
  resources :projects

  resources :orders, only: [:index, :show]
  get '/add_to_cart/:id', to: 'orders#add_to_cart', as: 'add_to_cart'
  get '/cart', to: 'orders#cart', as: 'cart'
  get '/remove_from_cart/:id', to: 'orders#remove_from_cart', as: 'remove_from_cart'
  get '/my_orders', to: 'users/profile#my_orders', as: 'my_orders'
  post '/callbacks/yandex_money', to: 'callbacks/yandex_money#perform'
  get '/download_project/:id', to: 'projects#download', as: 'download_project'
end
