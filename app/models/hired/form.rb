module Hired
  class Form < ApplicationRecord
    include Hired::Notifications

    self.table_name = "hired_forms"

    enum employment_type: {
      part_time: 1,
      full_time: 2
    }

    belongs_to :developer

    validates :address, :company, :position, :start_date, :employment_type, presence: true
  end
end
