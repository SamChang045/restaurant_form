class Friendship < ApplicationRecord

  # 確保特定 user_id 下，只能有一個 friendings_id
  validates :friending_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :friending, class_name: "User"

end
