class Business < ApplicationRecord
  include Avatarable

  enum :new_developer_notifications, [:no, :daily, :weekly], default: :no,
    suffix: :developer_notifications

  belongs_to :user
  has_many :conversations, -> { visible }

  validates :name, presence: true
  validates :company, presence: true
  validates :bio, presence: true
  validates :new_developer_notifications, presence: true

  after_create_commit :send_admin_notification

  private

  def send_admin_notification
    NewBusinessNotification.with(business: self).deliver_later(User.admin)
  end
end
