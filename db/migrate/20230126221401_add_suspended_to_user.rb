class AddSuspendedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :suspended, :boolean, null: false, default: false
  end
end
