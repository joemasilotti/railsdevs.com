class RemoveDevelopersExternalProfiles < ActiveRecord::Migration[7.0]
  def change
    drop_table :developers_external_profiles
  end
end
