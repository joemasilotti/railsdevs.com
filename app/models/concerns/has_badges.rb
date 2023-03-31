module HasBadges
  extend ActiveSupport::Concern

  # TODO #758: Cache developer badges to a new model
  BADGES = %i[high_response_rate source_contributor recently_active].freeze

  RECENTLY_ACTIVE_LENGTH = 1.week
  HIGH_RESPONSE_RATE_CUTTOFF = 90

  included do
    scope :recently_active, -> { where("developers.updated_at >= ?", RECENTLY_ACTIVE_LENGTH.ago) }
    scope :source_contributor, -> { where("source_contributor >= ?", true) }
    scope :high_response_rate, -> { where("response_rate >= ?", HIGH_RESPONSE_RATE_CUTTOFF) }
  end

  def recently_active?
    updated_at >= RECENTLY_ACTIVE_LENGTH.ago
  end

  def high_response_rate?
    response_rate >= HIGH_RESPONSE_RATE_CUTTOFF
  end
end
