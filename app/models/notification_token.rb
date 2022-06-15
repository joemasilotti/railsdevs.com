class NotificationToken < ApplicationRecord
  belongs_to :user

  validates :platform, inclusion: {in: %w[iOS Android]}
  validates :token, presence: true
end
