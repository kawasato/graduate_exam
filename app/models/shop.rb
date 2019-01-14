class Shop < ApplicationRecord
    validates :visitdate,
    presence: true,
    numericality: { only_integer: true, greater_than: 1990, less_than: 3000 }
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user
    mount_uploader :shop_image, ShopImageUploader
    mount_uploader :bread_image1, BreadImageUploader
    mount_uploader :bread_image2, BreadImageUploader
    mount_uploader :bread_image3, BreadImageUploader

end
