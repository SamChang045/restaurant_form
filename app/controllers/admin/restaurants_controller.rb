class Admin::RestaurantsController < ApplicationController

  #Before action region Start
  #
  #
  #
  #
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  before_action :set_restaurant, only:  [:show, :edit, :update, :destroy]
  #
  #
  #
  #
  #Before action region End


  #Function definition Start
  #
  #
  #
  #
  #由於是全部 (多筆) 餐廳資料，所以實例變數 ＠restaurants 使用複數。
  #用 Restaurant.all 撈出所有的餐廳資料並存入 @restaurants 這個實例變數。
  def index
    @restaurants = Restaurant.all
  end
  
  def show
  end

  def edit
  end

  #你宣告了一個 new 方法，用 Restaurant.new 建立一個新的餐廳實例 ＠restaurant，然後將這個實例存入變數，這裡要新增的資料只有一筆，所以依慣例 ＠restaurant 使用單數。
  def new
    @restaurant = Restaurant.new
  end

  #你必須將寫入參數的程序，從 new action 裡獨立出來，宣告成另一個私有方法。這裡依慣例命名為 restaurant_params。
  #使用 params 取出從 Client 端送進的 Request 裡，Controller 所需參數。
  #使用 require(:object_name) 拿出表單資料。
  #使用 permit 允許指定的屬性資料傳件 Model。

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end

  #這裡的邏輯和 create action 很類似：
  #如果資料庫修改成功，就導向該資料頁（show action），並顯示 flash message
  #如果資料庫修改失敗，就重新呼叫 edit 樣板，並顯示警告提示

  def update
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurant_path(@restaurant)
      flash[:notice] = "restaurant was successfully updated"
    else
      render :edit
      flash[:alert] = "restaurant was failed to update"
    end
  end

  #根據 routes.rb 裡的設定，我們可以透過 http://localhost:3000/admin/restaurants/:id 連進 admin/restaurants#destroy，進入 destroy action 時，會執行其中的邏輯程序：
  #網址中攜帶著 :id (實際執行時，會有一個真實的數字)，我們可以用 params 方法取出。
  #因為有了這筆數字，我們可以呼叫 Restaurant.find - 會透過 Restaurant Model，呼叫 find 方法，去 restaurants table 裡，把特定一筆資料撈出來。
  #將撈出的該筆資料存入 @restaurant。
  #呼叫 destroy 方法，將該筆資料刪除。

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "restaurant was deleted"
  end
  #
  #
  #
  #
  #Function definition End


  #Private definition Start
  #
  #
  #
  #
  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
  #
  #
  #
  #
  #Private definition End

end
