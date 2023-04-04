module HasBadges
  extend ActiveSupport::Concern

  # TODO #758: Cache developer badges to a new model
  BADGES = %i[high_response_rate source_contributor recently_added].freeze

  RECENTLY_ADDED_LENGTH = 1.week
  RECENTLY_UPDATED_LENGTH = 1.week
  HIGH_RESPONSE_RATE_CUTTOFF = 90

  included do
    scope :recently_added, -> { where("developers.created_at >= ?", RECENTLY_ADDED_LENGTH.ago) }
    scope :source_contributor, -> { where("source_contributor >= ?", true) }
    scope :high_response_rate, -> { where("response_rate >= ?", HIGH_RESPONSE_RATE_CUTTOFF) }
  end

  def recently_added?
    created_at >= RECENTLY_ADDED_LENGTH.ago
  end

  def high_response_rate?
    response_rate >= HIGH_RESPONSE_RATE_CUTTOFF
  end
end
