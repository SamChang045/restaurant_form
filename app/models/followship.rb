class Followship < ApplicationRecord
  # 「使用者追蹤使用者」的 self-referential relationships 設定
  # 由於 :following 指向 User Model, Rails 無法自動推論
  # 使用 :class_name 告知對應的 Model 名稱
  belongs_to :user
  belongs_to :following, class_name: "User"
end
