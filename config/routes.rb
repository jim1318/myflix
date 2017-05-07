require 'sidekiq/web'

Myflix::Application.routes.draw do
  root to: "pages#front"

  get 'ui(/:action)', controller: 'ui'
  get '/', to: 'videos#index'
  get 'home', to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  get 'register', to: "users#new"
  get 'register/:token', to: "users#new_with_invitation_token", as: "register_with_token"
  get 'sign_in', to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get 'sign_out', to: "sessions#destroy"

  get 'my_queue', to: 'queue_items#index'

  resources :users, only: [:create, :show]
  resources :people, to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]
  resources :sessions, only: [:create, :destroy]

  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'expired_token', to: 'pagesr#expired_token'
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]

  resources :invitations, only: [:new, :create]

  #For Sidekiq Monitoring
  mount Sidekiq::Web, at: '/sidekiq'


end
