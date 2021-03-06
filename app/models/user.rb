class User < ApplicationRecord

  validates :name, :exclusion => { :in => %w(edit) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  
  # 「使用者評論很多餐廳」的多對多關聯
  has_many :comments, dependent: :restrict_with_error
  has_many :commented_restaurants, through: :comments, source: :restaurant

  # 「使用者收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  # 「使用者喜歡很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurants

  # 「使用者追蹤使用者」的 self-referential relationships 設定
  # 不需要另加 source，Rails 可從 Followship Model 設定來判斷 followings 指向 User Model
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 「使用者的追蹤者」的設定
  # 透過 class_name, foreign_key 的自訂，指向 Followship 表上的另一側
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user


  # 「使用者追蹤的朋友」的 self-referential relationships 設定
  # 不需要另加 source，Rails 可從 Friendship Model 設定來判斷 friends 指向 User Model 
  has_many :friendships, dependent: :destroy
  #-has_many :friend_id, through: :friendships
  has_many :friends, -> { where(friendships: {status: "friend" } )}, through: :friendships
  has_many :send_applys, -> { where(friendships: {status: "applying" } )}, through: :friendships, source: :friend

  # 「使用者的朋友」的設定
  # 透過 class_name, foreign_key 的自訂，指向 Friendship 表上的另一側
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :applyers, -> { where(friendships: {status: "applying" } )}, through: :inverse_friendships, source: :user
  has_many :applyer_friends, -> { where(friendships: {status: "friend" } )}, through: :inverse_friendships, source: :user

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
  
  def is_friend?(user)
    if self.friends.include?(user) or self.applyer_friends.include?(user)  
        return true
    else
        return false
    end
  end


  def is_be_applying?(user)
    if self.applyers.include?(user) 
      return true
    else
      return false
    end
  end

  def is_applying?(user)
    if self.send_applys.include?(user) 
      return true
    else
      return false
    end
  end

end
