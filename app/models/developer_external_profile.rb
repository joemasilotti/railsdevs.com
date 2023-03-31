class DeveloperExternalProfile < ApplicationRecord
  enum :sites, %i[linkedin github]

  belongs_to :developer

  validates :developer, uniqueness: {scope: :site}

  def self.linkedin_developer(developer)
    find_by("developer_id = ? and site=?", developer.id, "linkedin")
  end

  def company(data_json)
    data_json["company"] unless data_json.blank?
  end
end
