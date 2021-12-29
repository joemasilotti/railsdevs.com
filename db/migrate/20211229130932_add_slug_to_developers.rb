class AddSlugToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :slug, :string
    add_index :developers, :slug, unique: true
  end
end
