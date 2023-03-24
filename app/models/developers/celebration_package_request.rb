module Developers
  class CelebrationPackageRequest < ApplicationRecord
    include Notifications

    self.table_name = "developers_celebration_package_requests"

    enum employment_type: {
      freelance_or_contract: 1,
      full_time_employment: 2
    }

    belongs_to :developer

    validates :address, :company, :position, :start_date, :employment_type, presence: true
  end
end
