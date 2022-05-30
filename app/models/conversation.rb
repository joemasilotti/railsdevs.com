class Conversation < ApplicationRecord
  belongs_to :developer
  belongs_to :business

  has_many :messages, -> { order(:created_at) }, dependent: :destroy

  has_noticed_notifications

  validates :developer_id, uniqueness: {scope: :business_id}

  scope :blocked, -> { where.not(developer_blocked_at: nil).or(Conversation.where.not(business_blocked_at: nil)) }
  scope :visible, -> { where(developer_blocked_at: nil, business_blocked_at: nil) }

  def other_recipient(user)
    recipient?(user.developer) ? business : developer
  end

  def recipient_from?(user)
    recipient_from(user).present?
  end

  def recipient_from(user)
    [ user.business, user.developer ].find { recipient?(_1) }
  end

  def recipient?(participant)
    participant.in? [ business, developer ]
  end

  def blocked?
    developer_blocked_at? || business_blocked_at?
  end

  def hiring_fee_eligible?
    developer_replied? && created_at <= 2.weeks.ago
  end

  private

  def developer_replied?
    messages.from_developer.any?
  end
end
