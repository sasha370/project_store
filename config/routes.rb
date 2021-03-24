# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'pages#home'

  resources :books, only: %i[index show]

  namespace :admin do
    resources :books
  end
end
