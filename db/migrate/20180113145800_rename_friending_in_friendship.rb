class RenameFriendingInFriendship < ActiveRecord::Migration[5.1]
  def change
    rename_column :friendships, :Friending_id, :friending_id
  end
end
