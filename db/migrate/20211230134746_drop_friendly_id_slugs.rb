class DropFriendlyIdSlugs < ActiveRecord::Migration[7.0]
  def up
    drop_table :friendly_id_slugs
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
