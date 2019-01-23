class Shop < ApplicationRecord
  validates :shop_name,presence: true
  validates :address,presence: true
  validates :visitdate,presence: true
  validate :visitdate_validation

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploader :shop_image, ShopImageUploader
  mount_uploader :bread_image1, BreadImageUploader
  mount_uploader :bread_image2, BreadImageUploader
  mount_uploader :bread_image3, BreadImageUploader

  def visitdate_validation
    if visitdate.present? && visitdate > Date.today
      errors.add(:visitdate, "は未来は入力できません。")
    end
  end

end