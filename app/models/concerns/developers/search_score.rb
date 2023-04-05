module Developers
  module SearchScore
    extend ActiveSupport::Concern

    included do
      before_save :update_search_score
    end

    def update_search_score
      self.search_score = calculate_search_score
    end

    private

    SMALL = 5
    MEDIUM = 10
    LARGE = 20
    X_LARGE = 30

    def calculate_search_score
      response_rate_score +
        source_contributor_score +
        scheduling_link_score +
        recently_updated_score +
        recently_added_score +
        bio_length_score
    end

    def response_rate_score
      return 0 if conversations_count == 0

      if response_rate >= HasBadges::HIGH_RESPONSE_RATE_CUTTOFF
        LARGE
      elsif response_rate <= HasBadges::LOW_RESPONSE_RATE_CUTTOFF
        -LARGE
      else
        0
      end
    end

    def scheduling_link_score
      scheduling_link.present? ? MEDIUM : 0
    end

    def source_contributor_score
      source_contributor.present? ? LARGE : 0
    end

    def recently_updated_score
      if 1.month.ago < profile_updated_at
        LARGE
      elsif 3.months.ago < profile_updated_at
        MEDIUM
      elsif profile_updated_at < 6.months.ago
        -MEDIUM
      else
        0
      end
    end

    def recently_added_score
      recently_added? ? X_LARGE : 0
    end

    def bio_length_score
      if bio.length > 500
        MEDIUM
      elsif bio.length < 50
        -LARGE
      else
        0
      end
    end
  end
end
