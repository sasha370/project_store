# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :books, only: %i[index show]

  namespace :admin do
    resources :books
  end
end
