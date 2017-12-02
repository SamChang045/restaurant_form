class Admin::RestaurantsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
  

  #由於是全部 (多筆) 餐廳資料，所以實例變數 ＠restaurants 使用複數。
  #用 Restaurant.all 撈出所有的餐廳資料並存入 @restaurants 這個實例變數。
  def index
    @restaurants = Restaurant.all
  end
  
  #你宣告了一個 new 方法，用 Restaurant.new 建立一個新的餐廳實例 ＠restaurant，然後將這個實例存入變數，這裡要新增的資料只有一筆，所以依慣例 ＠restaurant 使用單數。
  def new
    @restaurant = Restaurant.new
  end

end
