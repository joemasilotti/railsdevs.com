class AddSendStaleNotificationToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :send_stale_notification, :boolean, default: true
  end
end
