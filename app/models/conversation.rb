class Conversation < ApplicationRecord
  belongs_to :developer
  belongs_to :business

  has_many :messages, dependent: :destroy

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
end
