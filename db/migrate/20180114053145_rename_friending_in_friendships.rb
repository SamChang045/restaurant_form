class RenameFriendingInFriendships < ActiveRecord::Migration[5.1]
  def change
    rename_column :friendships, :friending_id, :friend_id
  end
end
