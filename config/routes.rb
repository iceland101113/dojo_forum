Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :replies, only: [:create, :update, :destroy]
  end
  
  root "posts#index"

  get "draft", to: "users#draft"
  
  resources :users, only: [:show, :edit, :update] 

  namespace :admin do
    resources :categories   
    resources :users, only: [:index, :update]
    root "categories#index"
  end

end
