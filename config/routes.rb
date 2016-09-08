Rails.application.routes.draw do

  root 'sessions#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/posts', to: 'posts#index'

  resources :sessions
  resources :users
  resources :posts, only: [:new, :create, :index]
end
