class Business < ApplicationRecord
  include Avatarable

  belongs_to :user
  has_many :conversations

  validates :name, presence: true
  validates :company, presence: true

  after_create :send_admin_notification

  def send_admin_notification
    NewBusinessNotification.with(business: self).deliver_later(User.admin)
  end
end
