class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shops
  has_many :favorites, dependent: :destroy
  has_many :favorite_shops ,through: :favorites,source: :shop
  validates :name, presence: true, length: { maximum: 30 }
end