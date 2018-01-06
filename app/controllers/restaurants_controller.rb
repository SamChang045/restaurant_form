class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  # GET restaurants/dashboard
  # 會去 render app/views/restuarants/dashboard.html.erb
  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  #當使用者點擊「Favorite」按鈕，瀏覽器使用 POST 動作，將請求送往 /restaurants/:id/favorite 的位址時，就會開始執行 Favorite action 裡的邏輯。
  #我們會先用 params[:id] 取出餐廳物件，接著，搭配 Devise 提供的 current_user 方法，新建一筆 Favorite 紀錄，並設定 restaurant_id 和 user_id 的外鍵。
  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    #@restaurant.count_favorites 
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  #和 Favorite 的邏輯相同，當使用者點擊「Unfavorite」按鈕，瀏覽器使用 POST 動件，將請求送往 /restaurants/:id/unfavorite 的位址時，就會開始執行 Unfavorite action 裡的邏輯。
  #第一步也是先用 params[:id] 取出餐廳物件。（為了教案示範，在教案中一直沒有設定 set_restaurant 方法，來重構查詢餐廳物件的動作）
  #接著，我們要利用 @restaurant 和 current_user 兩個線索，在 favorites table 上找到對應的 Favorite 紀錄。
  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.destroy_all
    #@restaurant.count_favorites
    redirect_back(fallback_location: root_path)
  end

  def like
    @restaurant = Restaurant.find(params[:id])
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unlike
    @restaurant = Restaurant.find(params[:id])
    like = Like.where(restaurant: @restaurant, user: current_user)
    like.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def ranking
    @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

end
