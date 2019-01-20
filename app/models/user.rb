class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shops, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_shops ,through: :favorites,source: :shop
  mount_uploader :user_image,UserImageUploader
  validates :name, presence: true, length: { maximum: 30 }
  validates :user_image, presence: true
end
