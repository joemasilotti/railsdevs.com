class Developer < ApplicationRecord
  has_one_attached :avatar

  validates :name, presence: true
  validates :email, presence: true
  validates :available_on, presence: true
  validates :hero, presence: true
  validates :bio, presence: true
  validates :avatar, content_type: ["image/png", "image/jpg", "image/jpeg"],
                     size: {less_than: 2.megabytes, message: "size cannot exced 2 MB"}

  belongs_to :user
end
