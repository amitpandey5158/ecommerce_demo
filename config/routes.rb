Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',

  }

  root "categories#index"

  resources :categories, only: [:show]
  resources :products, only: [:index, :show]

  resources :carts, only: [:show, :destroy] 
  get 'carts', to: 'carts#add_product_carts'
  get 'update_quantity', to: 'carts#update_quantity'
  get 'empty_cart', to: 'shared#empty_cart'
  
  resources :wishlists, only: [:show, :create, :destroy] 

  get 'search', to: "categories#search"
  get 'filter', to: "products#search"
  

end
