class Admin::CategoriesController < ApplicationController
  #Before action region Start
  #
  #
  #
  #
  before_action :authenticate_user!
  before_action :authenticate_admin
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
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
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
  #
  #
  #
  #
  #Private definition End


end
