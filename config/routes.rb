Rails.application.routes.draw do
  get 'income/show'

  post 'auctions/create'
  put '/auctions/approve-item/:id', to: 'auctions#approve_item'

  get 'items/new'
  post 'items/create'
  get '/all-items', to: 'items#all_items'
  put '/update-item-auction/:id', to: 'items#update_item_auction'
  resources :items

  get 'sessions/new'

  get '/home', to: 'static_pages#home'
  root to: redirect('/home')

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :income
  resources :bids
end
