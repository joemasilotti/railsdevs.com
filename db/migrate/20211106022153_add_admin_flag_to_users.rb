class AddAdminFlagToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
