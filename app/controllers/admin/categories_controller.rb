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
end
