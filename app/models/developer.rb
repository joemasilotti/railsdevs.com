class Developer < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  validates :name, presence: true
  validates :email, presence: true
  validates :available_on, presence: true
  validates :hero, presence: true
  validates :bio, presence: true
  validates :avatar, content_type: ["image/png", "image/jpg", "image/jpeg"],
    max_file_size: 2.megabytes
end
