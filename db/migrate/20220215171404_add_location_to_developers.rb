class AddLocationToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :location, :string
  end
end
