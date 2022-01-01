namespace :message_notifications do
  task backfill_conversations: :environment do
    Notification.where(type: "NewMessageNotification").find_each do |notification|
      message = notification.params[:message]
      conversation = message.conversation
      notification.update!(params: {message: message, conversation: conversation})
    end
  end
end
