class AddBioToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :bio, :text, null: false
  end
end
