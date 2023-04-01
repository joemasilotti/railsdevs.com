module Developers
  class ExternalProfile < ApplicationRecord
    enum :sites, %i[linkedin]

    belongs_to :developer

    validates :developer, uniqueness: {scope: :site}

    def self.linkedin_developer(developer)
      find_by("developer_id = ? and site=?", developer.id, "linkedin")
    end

    def company(data_json)
      data_json["company"]
    end
  end
end
