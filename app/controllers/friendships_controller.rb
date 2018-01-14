class FriendshipsController < ApplicationController

  def index
    @applyers = current_user.applyers
    @friends = current_user.friends + current_user.applyer_friends
  end

  def update
    @friendship = Friendship.where(friend_id: current_user.id ,user_id: params[:id], status: "applying").first
    @user = User.find(params[:id])

    if @friendship.update(status: "friend")
      flash[:notice] = "Successfully added #{@user.name} in friend list"
    else
      flash[:alert] = "Fail to add friend"
    end

    redirect_to friendships_path
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], status: "applying")

    if @friendship.save
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: user_path(current_user))
  end


  def destroy

    if current_user.inverse_friendships.where(user_id: params[:id]).present?
      @friendship = current_user.inverse_friendships.where(user_id: params[:id])
      @friendship.destroy_all
      @user = User.find(params[:id])
      flash[:notice] = "Successfully deleted #{@user.name} from friend list"
    elsif current_user.friendships.where(friend_id: params[:id]).present?
      @friendship = current_user.friendships.where(friend_id: params[:id])
      @friendship.destroy_all
    end

    redirect_back(fallback_location: friendships_path)
  end

end
