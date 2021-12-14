class Business < ApplicationRecord
  include Avatarable

  belongs_to :user
  has_many :conversations

  validates :name, presence: true
  validates :company, presence: true
  validates :bio, presence: true

  after_create :send_admin_notification

  def hero
    "#{name} @ #{company}"
  end

  private

  def send_admin_notification
    NewBusinessNotification.with(business: self).deliver_later(User.admin)
  end
end
