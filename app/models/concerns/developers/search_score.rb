# Recommended sorting alorithm for developer profiles in search results.
# v1.0 - last updated April 6, 2023
#
# | Property                  | Effect on score |
# | ------------------------- | --------------- |
# | Add a scheduling link     | medium boost    |
# | Source contributors       | medium boost    |
# | Profile added last 7 days | large boost     |
# | Bio < 50 characters       | medium demotion |
# | Bio > 500 characters      | small boost     |
# | Updated > 6 months ago    | small demotion  |
# | Updated 3-6 months ago    | small boost     |
# | Updated within last month | medium boost    |
# | ≥ 90% response rate       | medium boost    |
# | ≤ 10% response rate       | medium demotion |
#
module Developers::SearchScore
  extend ActiveSupport::Concern

  included do
    small, medium, large = 10, 20, 30

    scores :scheduling_link?, by: small, if: :present?
    scores :source_contributor?, by: medium, if: :present?
    scores :recently_added?, by: large, if: :present?

    scores :bio, by: -medium, if: -> { _1.length < 50 if _1 }
    scores :bio, by: small, if: -> { _1.length > 500 if _1 }

    scores :profile_updated_at, by: -small, if: -> { _1&.before? 6.months.ago }
    scores :profile_updated_at, by: small, if: -> { _1 && (3.months.ago..1.month.ago).cover?(_1) }
    scores :profile_updated_at, by: medium, if: -> { _1&.after? 1.month.ago }

    scores :response_rate, by: medium, if: -> { conversations? && _1 >= HasBadges::HIGH_RESPONSE_RATE_CUTTOFF }
    scores :response_rate, by: -medium, if: -> { conversations? && _1 <= HasBadges::LOW_RESPONSE_RATE_CUTTOFF }

    after_create_commit :update_search_score
    before_update :update_search_score
  end

  class_methods do
    attr_reader :scorings

    def scores(attribute, by:, **options)
      @scorings ||= Hash.new { |h, k| h[k] = [] }
      @scorings[attribute] << -> { by if instance_exec(public_send(attribute), &options.fetch(:if)) }
    end
  end

  MAX_SCORE = 110

  def update_search_score
    score = score_for(*self.class.scorings.keys)
    normalized_score = score.fdiv(MAX_SCORE) * 100
    self.search_score = normalized_score.round
  end

  def score_for(*attributes)
    self.class.scorings.fetch_values(*attributes).flatten(1).filter_map { instance_exec(&_1) }.sum
  end

  private

  def conversations?
    conversations_count.positive?
  end
end
