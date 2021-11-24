class AddRemoteAndLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :remote, :boolean, default: false, null: false
    add_column :developers, :location, :text
  end
end
