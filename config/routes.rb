Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/show'
  get 'groups/edit'
  get 'categories/index'
  devise_for :users
  root to: 'homes#top'
  get 'about', to: 'homes#about', as: 'about'
  get 'index', to: 'homes#index', as: 'index'
  resources :users, only: [:edit, :update, :show, :index] do
    resource :relationships, only: [:create, :destroy]
    get 'followings', to: 'relationships#followings', as: 'followings'
    get 'followers', to: 'relationships#followers', as: 'followers'
    get 'index', to: 'users#post_index', as: 'post_index'
    get 'chats', to: 'chats#index', as: 'chats'
  end
  devise_scope :user do
    post "users_guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :recommend_place_posts do
    resource :post_favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy] do
      resource :comment_favorite, only: [:create, :destroy]
    end
  end
  get 'searches/result', to: 'searches#search', as: 'search'
  get 'searches/new', to: 'searches#new', as: 'new_search'
  resources :chats, only: [:create, :show]
  resources :notifications, only: [:update]
  resources :categories, only: [:index, :create] do
    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :group_users, only: [:destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
