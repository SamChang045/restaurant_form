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
  end
  #
  #
  #
  #
  #Function definition End
  
end
