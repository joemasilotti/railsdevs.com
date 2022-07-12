module OpenStartup
  class Metric < ApplicationRecord
    self.table_name = "open_startup_metrics"

    store :data, accessors: %i[mrr visitors], coder: JSON

    validates :occurred_on, presence: true

    def self.most_recent
      order(occurred_on: :desc).first
    end
  end
end
