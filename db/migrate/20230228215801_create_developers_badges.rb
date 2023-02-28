class CreateDevelopersBadges < ActiveRecord::Migration[7.0]
  def change
    create_table :developers_badges do |t|
      t.belongs_to :developer, null: false, foreign_key: true
      t.boolean :recently_active, null: false, default: true
      t.boolean :source_contributor, null: false, default: false
      t.timestamps
    end
  end
end
