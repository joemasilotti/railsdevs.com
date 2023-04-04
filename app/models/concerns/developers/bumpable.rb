module Developers
  module Bumpable
    extend ActiveSupport::Concern

    included do
      before_update :touch_bumped_at, if: :user_initiated
    end

    attr_accessor :user_initiated, :specialties_changed

    def specialty_changed(specialty)
      self.specialties_changed = true
    end

    private

    SIGNIFICANT_ATTRIBUTES = %w[
      name
      hero
      bio
      search_status
      website
      github
      linkedin
      stack_overflow
      twitter
      mastodon
      scheduling_link
    ]

    def touch_bumped_at
      if significant_changes? || specialties_changed
        self.profile_updated_at = Time.current
        self.bumped_at = Time.current unless recently_bumped?
      end
    end

    def significant_changes?
      (SIGNIFICANT_ATTRIBUTES & changes.keys).any? ||
        role_type.changed? ||
        role_level.changed? ||
        location.changed?
    end

    def recently_bumped?
      1.month.ago < bumped_at
    end
  end
end
