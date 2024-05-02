Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'about', to: 'homes#about', as: 'about'
  get 'index', to: 'homes#index', as: 'index'
  resources :users, only: [:edit, :update, :show, :index]
  devise_scope :user do
    post "users_guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :recommend_place_posts do
    resources :post_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
