module Conversation::Blocker
  extend ActiveSupport::Concern

  included do
    scope :blocked, -> { where.not(developer_blocked_at: nil).or(Conversation.where.not(business_blocked_at: nil)) }
    scope :visible, -> { where(developer_blocked_at: nil, business_blocked_at: nil) }
  end

  def blocked_by(user)
    case recipient_from(user)
    when Business
      touch :business_blocked_at
    when Developer
      touch :developer_blocked_at
    end
  end

  def blocked?
    business_blocked_at? || developer_blocked_at?
  end
end
