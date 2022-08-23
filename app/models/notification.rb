class Notification < ApplicationRecord
  include Noticed::Model

  belongs_to :recipient, polymorphic: true

  scope :visible, -> { where.not(type: Developers::CelebrationPromotionNotification.name) }
end
