class FollowshipsController < ApplicationController

  def index
    @users = User.all
  end

end
