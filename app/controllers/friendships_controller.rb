class FriendshipsController < ApplicationController

  def create
    # 需要設定前端的 link_to，在發出請求時送進 friending_id
    @friendship = current_user.friendships.build(friending_id: params[:friending_id])

    if @friendship.save
      flash[:notice] = "Congratulations! you both are friends"
      redirect_back(fallback_location: root_path)
    else
      # 驗證失敗時，Model 將錯誤訊息放在 errors 裡回傳
      # 使用 errors.full_messages 取出完成訊息集合(Array)，串接 to_sentence 將 Array 組合成 String
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

end
