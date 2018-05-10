Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :replies, only: [:create, :edit, :update, :destroy]

    member do
      # 其他程式碼
      post :collect
      post :uncollect
    end
  end

  
  root "posts#index"

  get "draft", to: "users#draft"

  
  resources :users, only: [:show, :edit, :update] do
    resources :replies, only: [:edit, :update, :destroy]
  end

  namespace :admin do
    resources :categories   
    resources :users, only: [:index, :update]
    root "categories#index"
  end

end
