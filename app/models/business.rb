class Business < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  validates :name, presence: true
  validates :company, presence: true
end
