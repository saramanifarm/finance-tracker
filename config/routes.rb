Rails.application.routes.draw do
  devise_for :users
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  delete 'delete_friend', to: 'friends#destroy'
  post 'add_friend', to: 'friends#create'
  get 'search_stock', to: 'stocks#search'
  get 'search_friends', to: 'friends#search'
end
