class User < ApplicationRecord
  devise :confirmable,
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :validatable
  pay_customer

  has_many :notifications, as: :recipient
  has_one :business, dependent: :destroy
  has_one :developer, dependent: :destroy

  has_many :conversations, ->(user) {
    unscope(where: :user_id)
      .left_joins(:business, :developer)
      .where("businesses.user_id = ? OR developers.user_id = ?", user.id, user.id)
      .visible
  }

  scope :admin, -> { where(admin: true) }

  def active_business_subscription?
    subscriptions.any?(&:active?)
  end

  def message_notifications
    if developer.present? && business.present?
      developer_notifications.or(business_notifications).order(created_at: :desc)
    elsif developer.present?
      developer_notifications.order(created_at: :desc)
    elsif business.present?
      business_notifications.order(created_at: :desc)
    else
      Notification.none
    end
  end

  def conversation_notifications(conversation)
    message_notifications.select { |n| n.conversation == conversation && n.unread? }
  end

  private

  def developer_notifications
    Notification.where(recipient_type: "Developer", recipient: developer)
  end

  def business_notifications
    Notification.where(recipient_type: "Business", recipient: business)
  end
end
