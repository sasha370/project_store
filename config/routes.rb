# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  ActiveAdmin.routes(self)
  root to: 'pages#index'
  get 'privacy_policy', to: 'pages#privacy_policy'
  resources :projects

  get '/add_to_cart/:id', to: 'purchasments#add_to_cart', as: 'add_to_cart'
end
