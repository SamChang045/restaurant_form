class Admin::CategoriesController < Admin::BaseController
  #Before action region Start
  #
  #
  #
  #
  before_action :set_restaurant, only:  [:update, :destroy]
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
  #修改 index action，傳入 form_for 需要的參數
  #為解決 form_for 沒有 @category 的問題，請你跟著以下步驟操作：
  #在 index action 中宣告 @category
  #透過 new 方法新增一個空的 Category 物件
  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
  end

  #我們需要使用 Strong parameter 來允許表單傳入資料，因此會另外建立一個 category_params 方法，並設定為私有方法。
  #儲存失敗時，由於要重新 render index 樣板，需要再額外傳入 index 需要的 @categories 實例變數。
  def create
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  #實作 update action 和 create action 的邏輯相似——首先，#我們需要找到特定的 Category 資料，
  #並且寫一個 if...else 條件式，  #如果通過 Model 的驗證，成功儲存到資料庫裡，就導向適合的頁面，
  #並留給使用者成功訊息；如果不成功，就重新 render index 樣板，並傳入 index 樣板需要的 @categories 變數，
  #使用者有重新輸入的機會。
  def update
    if @category.update(category_params)
      flash[:notice] = "category was successfully updated"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  #請注意，目前我們尚未重構程式碼，因此需要在 destroy action 開始前，先加入 @category = Category.find(params[:id])，找到特定的一筆 Category 資料。
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:alert] = "category was successfully deleted"
    redirect_to admin_categories_path
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

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
  #
  #
  #
  #
  #Private definition End


end
