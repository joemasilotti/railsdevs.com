module OpenStartup
  class Metric < ApplicationRecord
    self.table_name = "open_startup_metrics"

    store :data, accessors: %i[mrr visitors]
  end
end
