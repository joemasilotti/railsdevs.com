class AddDeveloperNotificationsToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :developer_notifications, :integer, default: 0, null: false
  end
end
