class Conversation < ApplicationRecord
  belongs_to :developer
  belongs_to :business

  has_many :messages, dependent: :destroy

  validates :developer_id, uniqueness: {scope: :business_id}

  scope :visible, -> { where(blocked_by_developer_at: nil, blocked_by_business_at: nil) }

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
    blocked_by_developer_at.present? || blocked_by_business_at.present?
  end
end
