class CreateDeveloperExternalProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :developer_external_profiles do |t|
      t.references :developer, null: false, foreign_key: true
      t.string :site, null: false
      t.jsonb :data
      t.string :error

      t.timestamps
      t.index [:developer_id, :site], unique: true
    end
  end
end
