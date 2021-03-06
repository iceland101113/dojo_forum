Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :replies, only: [:create, :edit, :update, :destroy]

    member do
      post :collect
    end

    collection do
      get :feeds
    end
  end

  
  root "posts#index"

  get "draft", to: "users#draft"

  
  resources :users, only: [:show, :edit, :update] do
    resources :replies, only: [:edit, :update, :destroy]

    member do
      post :collect
      post :friend
      post :accept
      post :ignore
    end

  end

  resources :categories, only: :show

  namespace :admin do
    resources :categories   
    resources :users, only: [:index, :update]
    root "categories#index"
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"

      resources :posts, only: [:index, :create, :show, :update, :destroy]
    end
  end

end
