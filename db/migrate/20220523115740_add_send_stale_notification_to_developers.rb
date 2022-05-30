class AddSendStaleNotificationToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :profile_reminder_notifications, :boolean, default: true
  end
end
