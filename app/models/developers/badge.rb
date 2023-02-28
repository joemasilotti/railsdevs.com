module Developers
  class Badge < ApplicationRecord
    self.table_name = "developers_badges"

    BADGES = %i[recently_active source_contributor].freeze

    belongs_to :developer
  end
end
