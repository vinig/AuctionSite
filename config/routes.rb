Rails.application.routes.draw do
  get 'sessions/new'

  get 'static_pages/home'

  root 'static_pages#home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
