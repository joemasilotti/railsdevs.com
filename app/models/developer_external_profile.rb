class DeveloperExternalProfile < ApplicationRecord
  enum :sites, %i[linkedin github]

  belongs_to :developer

  validates :developer, uniqueness: {scope: :site}

  def self.linkedin_developer(developer)
    where("developer_id = ? and site=?", developer.id, "linkedin").first!
  end
end
