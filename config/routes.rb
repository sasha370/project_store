# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#index'
  get 'privacy_policy', to: 'pages#privacy_policy'
  resources :books, only: %i[index show]
  resources :categories, only: %i[index show]
end
