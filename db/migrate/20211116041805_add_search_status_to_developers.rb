class AddSearchStatusToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :search_status, :integer
  end
end
