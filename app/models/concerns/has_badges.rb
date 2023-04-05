module HasBadges
  extend ActiveSupport::Concern

  # TODO #758: Cache developer badges to a new model
  BADGES = %i[
    high_response_rate
    source_contributor
    recently_added
    recently_updated
  ]

  RECENT_CHANGES_LENGTH = 1.week
  HIGH_RESPONSE_RATE_CUTTOFF = 90
  LOW_RESPONSE_RATE_CUTTOFF = 50

  included do
    scope :high_response_rate, -> { where("response_rate >= ?", HIGH_RESPONSE_RATE_CUTTOFF) }
    scope :source_contributor, -> { where(source_contributor: true) }
    scope :recently_added, -> { where("developers.created_at >= ?", RECENT_CHANGES_LENGTH.ago) }
    scope :recently_updated, -> { where("developers.profile_updated_at >= ?", RECENT_CHANGES_LENGTH.ago) }
  end

  def high_response_rate?
    response_rate >= HIGH_RESPONSE_RATE_CUTTOFF
  end

  def recently_added?
    created_at >= RECENT_CHANGES_LENGTH.ago
  end

  def recently_updated?
    profile_updated_at >= RECENT_CHANGES_LENGTH.ago
  end
end
