# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#index'
  get 'privacy_policy', to: 'pages#privacy_policy'
  resources :projects, only: %i[index show]
end
