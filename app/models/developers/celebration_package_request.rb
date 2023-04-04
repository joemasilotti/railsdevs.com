module Developers
  class CelebrationPackageRequest < ApplicationRecord
    include CelebrationPackageRequests::Notifications

    enum employment_type: {
      freelance_or_contract: 1,
      full_time_employment: 2
    }

    belongs_to :developer

    validates :address, :company, :position, :start_date, :employment_type, presence: true
  end
end
