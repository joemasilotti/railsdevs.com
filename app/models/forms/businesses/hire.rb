module Forms
  module Businesses
    class Hire < ApplicationRecord
      self.table_name = "forms_businesses_hires"
      include Forms::Businesses::Notifications

      enum employment_type: {
        freelance_or_contract: 1,
        full_time_employment: 2
      }

      belongs_to :business

      validates :business, :billing_address, :developer_name, :start_date, :annual_salary, :employment_type, presence: true
    end
  end
end
