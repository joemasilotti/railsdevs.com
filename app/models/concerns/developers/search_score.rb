module Developers::SearchScore
  extend ActiveSupport::Concern

  included do
    _small, medium, large, x_large = 5, 10, 20, 30

    scores :scheduling_link?, by: medium, if: :present?
    scores :source_contributor?, by: large, if: :present?
    scores :recently_added?, by: x_large, if: :present?

    scores :bio, by: medium, if: -> { _1.length > 500 if _1 }
    scores :bio, by: -large, if: -> { _1.length < 50 if _1 }

    scores :profile_updated_at, by: -medium, if: -> { _1&.before? 6.months.ago }
    scores :profile_updated_at, by: medium, if: -> { _1 && (3.months.ago..1.month.ago).cover?(_1) }
    scores :profile_updated_at, by: large, if: -> { _1&.after? 1.month.ago }

    scores :response_rate, by: large, if: -> { conversations_count.positive? && _1 >= HasBadges::HIGH_RESPONSE_RATE_CUTTOFF }
    scores :response_rate, by: -large, if: -> { conversations_count.positive? && _1 <= HasBadges::LOW_RESPONSE_RATE_CUTTOFF }

    before_save :update_search_score
  end

  class_methods do
    attr_reader :scorings

    def scores(attribute, by:, **options)
      @scorings ||= Hash.new { |h, k| h[k] = [] }
      @scorings[attribute] << -> { by if instance_exec(public_send(attribute), &options.fetch(:if)) }
    end
  end

  def update_search_score
    self.search_score = score_for(*self.class.scorings.keys)
  end

  def score_for(*attributes)
    self.class.scorings.fetch_values(*attributes).flatten(1).filter_map { instance_exec(&_1) }.sum
  end
end
