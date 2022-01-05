class AddNewDeveloperNotificationsToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :new_developer_notifications, :integer, default: 0
  end
end
