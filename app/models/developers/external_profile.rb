module Developers
  class ExternalProfile < ApplicationRecord
    enum :sites, %i[linkedin]

    belongs_to :developer

    validates :developer, uniqueness: {scope: :site}

    def self.linkedin_developer(developer)
      find_by(developer:, site: "linkedin")
    end

    def company(data_json)
      data_json["company"]
    end
  end
end
