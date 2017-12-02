Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    #resourcess 會為你產生一組 URL Helper 和網址，並對應到不同的 Action。
    root "restaurants#index"
  end
  
end
