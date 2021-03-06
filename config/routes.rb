# frozen_string_literal: true

Rails.application.routes.draw do
  ########## Resources ##########
  devise_for :users
  resources :users, only: [:show]
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]

  ########## Stocks controller ##########
  get 'search_stock', to: 'stocks#search'
  # get 'update_stock', to: 'stocks#update'
  post 'update_stock_last_price', to: 'stocks#update_last_price'

  ########## Users controller ##########
  root 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search_friend'
end
