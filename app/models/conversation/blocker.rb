module Conversation::Blocker
  extend ActiveSupport::Concern

  included do
    has_many :blocks

    scope :blocked, -> { where.associated(:blocks) }
    scope :visible, -> { where.missing(:blocks) }
  end

  def blocked_by(user)
    blocks.find_or_create_by!(blocker: user, blockee: other_recipient(user).user)
  end

  def blocked?
    blocks.any?
  end
end
