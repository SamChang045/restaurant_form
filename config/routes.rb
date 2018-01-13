Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #根據 RESTful 設計，resources 會開放 7 種 action，然而，前台使用者的行為只有 index action 和 show action。因此我們使用 :only 來限制要宣告的資源。
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    collection do
      
      # 瀏覽所有餐廳的最新動態
      # GET restaurants/feeds
      get :feeds

      # 十大人氣餐廳
      get :ranking
    end


    member do

      # 瀏覽個別餐廳的 Dashboard
      # GET restaurants/:id/dashboard
      get :dashboard

      # 收藏 / 取消收藏
      post :favorite
      post :unfavorite

      # 喜歡 / 取消喜歡
      post :like
      post :unlike
    end

  end

  resources :users, only: [:index, :show, :edit, :update]

  resources :followships, only: [:create, :destroy]

  resources :friendships, only: [:create, :destroy]
  
  resources :categories, only: :show
  
  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    resources :categories 
    #resourcess 會為你產生一組 URL Helper 和網址，並對應到不同的 Action。
    root "restaurants#index"
  end
  
end
