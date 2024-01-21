module Developers
  module PublicChanges
    extend ActiveSupport::Concern

    included do
      before_update :touch_profile_updated_at, if: :user_initiated
    end

    attr_accessor :user_initiated, :specialties_changed

    def specialty_changed(specialty)
      self.specialties_changed = true
    end

    private

    PUBLIC_ATTRIBUTES = %w[
      name
      hero
      bio
      search_status
      website
      github
      gitlab
      linkedin
      stack_overflow
      twitter
      mastodon
      scheduling_link
    ]

    def touch_profile_updated_at
      self.profile_updated_at = Time.current if pulic_changes?
    end

    def pulic_changes?
      (PUBLIC_ATTRIBUTES & changes.keys).any? ||
        role_type.changed? ||
        role_level.changed? ||
        location.changed? ||
        specialties_changed
    end
  end
end
