Myflix::Application.routes.draw do
  root to: "pages#front"

  get 'ui(/:action)', controller: 'ui'
  get '/', to: 'videos#index'
  get 'home', to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end

  resources :categories, only: [:show]

  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get 'sign_out', to: "sessions#destroy"

  resources :users, only: [:create]
  resources :sessions, only: [:create, :destroy]

end
