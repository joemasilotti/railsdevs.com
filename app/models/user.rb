class User < ApplicationRecord
  devise :confirmable,
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :validatable

  has_one :developer
  has_many :notifications, as: :recipient

  scope :admin, -> { where(admin: true) }
end
