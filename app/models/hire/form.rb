module Hire
  class Form < ApplicationRecord
    self.table_name = "hire_forms"
    include Hire::Notifications

    enum employment_type: {
      freelance_or_contract: 1,
      full_time_employment: 2
    }

    belongs_to :business

    validates :business, :billing_address, :developer_name, :start_date, :annual_salary, :employment_type, presence: true
  end
end
