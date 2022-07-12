class AddRemoteWorkPreferenceToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :remote_work_preference, :integer
  end
end
