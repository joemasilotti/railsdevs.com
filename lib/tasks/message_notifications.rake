namespace :message_notifications do
  task backfill_conversations: :environment do
    Notification.where(type: "NewMessageNotification").find_each do |notification|
      instance = notification.to_notification
      notification.update!(
        recipient: notification.recipient.user,
        params: {
          message: instance.message,
          conversation: instance.message.conversation
        }
      )

      # The associated developers with these notifications where deleted.
      Notification.where(id: [1, 98]).destroy_all
    end
  end

  task mark_as_read: :environment do
    Notification.mark_as_read!
  end
end
