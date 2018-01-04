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
  
  def admin?
    self.role == "admin"
  end
  
end
