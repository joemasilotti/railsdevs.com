class Conversation < ApplicationRecord
  has_secure_token :inbound_email_token

  belongs_to :developer
  belongs_to :business

  has_many :messages, -> { order(:created_at) }, dependent: :destroy

  has_noticed_notifications

  validates :developer_id, uniqueness: {scope: :business_id}

  scope :blocked, -> { where.not(developer_blocked_at: nil).or(Conversation.where.not(business_blocked_at: nil)) }
  scope :visible, -> { where(developer_blocked_at: nil, business_blocked_at: nil) }

  def other_recipient(user)
    developer == user.developer ? business : developer
  end

  def business?(user)
    business == user.business
  end

  def developer?(user)
    developer == user.developer
  end

  def blocked?
    developer_blocked_at.present? || business_blocked_at.present?
  end

  def hiring_fee_eligible?
    developer_replied? && created_at <= 2.weeks.ago
  end

  def latest_message_read_by_other_recipient?(user)
    return false unless latest_message

    other_user = other_recipient(user).user

    notification = latest_message.latest_notification_for_recipient(other_user)
    notification&.read?
  end

  def latest_message
    messages.reorder(created_at: :desc).first
  end

  def mark_notifications_as_read(user)
    notifications_as_conversation.where(recipient: user).unread.mark_as_read!
  end

  private

  def developer_replied?
    messages.from_developer.any?
  end
end
