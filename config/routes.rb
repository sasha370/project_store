Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :books, only: [:index, :show]

  namespace :admin do
    resources :books
  end
end
