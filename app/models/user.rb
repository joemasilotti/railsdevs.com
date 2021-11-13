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

  def has_developer_profile?
    developer&.persisted?
  end
end
