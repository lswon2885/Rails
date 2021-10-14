Rails.application.routes.draw do
  root "home#index"

  get 'mypage' => 'home#mypage'

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :packs, only: [:index, :show]

  resources :carts, only: [:create, :index, :destroy]

  resources :orders, only: [:create, :show, :index] do
    resources :payments, only: [:create]

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
