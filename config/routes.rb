Rails.application.routes.draw do
  # get '/login',to: 'user#new'
  # post '/login',to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :labels
  resources :labelings, only: [:create, :destroy]
  root 'sessions#new'
  resources :users, only: [ :new, :create, :show]
  namespace :admin do
    resources :users
  end
end
