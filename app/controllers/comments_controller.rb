class CommentsController < ApplicationController

  def create
    #(1) 確認餐廳物件：@restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant = Restaurant.find(params[:restaurant_id])

    #(2) 透過關聯建立一個新的評論：@comment = @restaurant.comments.build(comment_params)
    @comment = @restaurant.comments.build(comment_params)

    #(3) 確認關聯的使用者：@comment.user = current_user
    @comment.user = current_user

    #(4) 存入資料庫並重新導向
    @comment.save!
    redirect_to restaurant_path(@restaurant)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end

