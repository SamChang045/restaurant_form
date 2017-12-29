Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #根據 RESTful 設計，resources 會開放 7 種 action，然而，前台使用者的行為只有 index action 和 show action。因此我們使用 :only 來限制要宣告的資源。
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
  end
  resources :categories, only: :show
  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    resources :categories 
    #resourcess 會為你產生一組 URL Helper 和網址，並對應到不同的 Action。
    root "restaurants#index"
  end
  
end
