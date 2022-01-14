class Business < ApplicationRecord
  include Avatarable

  enum :developer_notifications, %i[no daily weekly], default: :no, suffix: true

  belongs_to :user
  has_many :conversations, -> { visible }

  validates :name, presence: true
  validates :company, presence: true
  validates :bio, presence: true
  validates :developer_notifications, inclusion: {in: developer_notifications.keys}

  after_create_commit :send_admin_notification

  private

  def send_admin_notification
    NewBusinessNotification.with(business: self).deliver_later(User.admin)
  end
end
