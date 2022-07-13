class AddRemoteWorkPreferenceToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :location_preference, :integer
  end
end
