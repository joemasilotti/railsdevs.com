class AddFetchedAtToDevelopersExternalProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :developers_external_profiles, :fetched_at, :datetime
  end
end
