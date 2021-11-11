class Developer < ApplicationRecord
  include Availability

  belongs_to :user
  has_one_attached :avatar
  has_one_attached :cover_image

  validates :name, presence: true
  validates :hero, presence: true
  validates :bio, presence: true
  validates :avatar, content_type: ["image/png", "image/jpg", "image/jpeg"],
    max_file_size: 2.megabytes
  validates :cover_image, content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"],
    max_file_size: 10.megabytes

  scope :available, -> { where("available_on <= ?", Date.today) }
  scope :most_recently_added, -> { order(created_at: :desc) }
end
