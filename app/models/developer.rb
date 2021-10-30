class Developer < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :available_on, presence: true
  validates :hero, presence: true
  validates :bio, presence: true

  belongs_to :user
end
