class SpecialtyTag < ApplicationRecord
  belongs_to :specialty, counter_cache: :developers_count
  belongs_to :developer
end
