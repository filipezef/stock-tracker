Rails.application.routes.draw do
  get 'users/my_portfolio'
  ########## Resources ##########
  devise_for :users
  resources :users, only: [:show]
  root 'pages#index'

  ########## Stocks controller ##########
  get 'search_stock', to: 'stocks#search'

  ########## Users controller ##########
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
end
