class CreateGithubProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :github_profiles do |t|
      t.string :organizations, array: true
      t.string :company
      t.references :developer
      t.timestamps
    end
  end
end
