# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'
  get 'privacy_policy', to: 'pages#privacy_policy'
  resources :books, only: %i[index show]
end
