namespace :message_notifications do
  task backfill_conversations: :environment do
    Notification.where(type: "NewMessageNotification").find_each do |n|
      notification = n.to_notification
      notification.update!(params: {
        message: notification.message,
        conversation: notification.conversation
      })
    end
  end

  task mark_as_read: :environment do
    Notification.where(type: "NewMessageNotification").mark_as_read!
  end
end
