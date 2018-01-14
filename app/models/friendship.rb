class Friendship < ApplicationRecord

  # 確保特定 user_id 下，只能有一個 friend_id
  validates :friend_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :friend, class_name: "User"

end
