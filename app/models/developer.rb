class Developer < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :available_on, presence: true
  validates :hero, presence: true
  validates :bio, presence: true
  validates :avatar, content_type: ["image/png", "image/jpg", "image/jpeg"]

  belongs_to :user
  has_one_attached :avatar
end
