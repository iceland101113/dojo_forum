Rails.application.routes.draw do
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

  namespace :admin do
    resources :categories   
    resources :users, only: [:index, :update]
    root "categories#index"
  end

end
