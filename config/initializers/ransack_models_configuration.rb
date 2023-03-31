# Initializers may be not the best place to store ransack configuration for models
# especially during active development, but as a starting point it helps to avoid
# spreading changes across code base.
# This configuration allows to build queries using ransack based on user input
# (which it is actually built for). However, it may cause security issues if handled
# incorrectly. Some details here https://github.com/activerecord-hackery/ransack/issues/1273
Rails.configuration.after_initialize do
  class Developer < ApplicationRecord
    class << self
      def ransackable_attributes(auth_object = nil)
        ["name"]
      end

      def ransackable_scopes_skip_sanitize_args # https://github.com/activerecord-hackery/ransack/issues/1232
        ["with_specialty_ids"]
      end

      def ransackable_associations(auth_object = nil)
        ["role_type", "role_level", "location"]
      end

      def ransackable_scopes(auth_object = nil)
        ["recently_active", "source_contributor", "high_response_rate", "actively_looking_or_open_only", "with_specialty_ids", "filter_by_search_query"]
      end
    end
  end

  class Location < ApplicationRecord
    class << self
      def ransackable_attributes(auth_object = nil)
        ["country", "utc_offset"]
      end
    end
  end

  class RoleType < ApplicationRecord
    class << self
      def ransackable_attributes(auth_object = nil)
        RoleType::TYPES.map(&:to_s)
      end

      def ransackable_associations(auth_object = nil)
        ["developer"]
      end
    end
  end

  class RoleLevel < ApplicationRecord
    class << self
      def ransackable_attributes(auth_object = nil)
        RoleLevel::TYPES.map(&:to_s)
      end

      def ransackable_associations(auth_object = nil)
        ["developer"]
      end
    end
  end
end