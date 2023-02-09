module Developers
  class Badge < ApplicationRecord
    self.table_name = 'developers_badges'

    belongs_to :developer
  end
end
