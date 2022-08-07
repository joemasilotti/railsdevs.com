desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task backfill_conversation_unread_status: :environment do
    # As long as there is one unread message, don't run. Hopefully idempotent _enough_.
    return if Conversation.where.not(user_with_unread_messages: nil).exists?
    Conversation.where(user_with_unread_messages: nil).includes(:messages).each do |conversation|
      last_notification = conversation.messages.last.notifications_as_message.last
      if last_notification&.unread?
        conversation.update(user_with_unread_messages: last_notification.recipient)
      end
    end
  end
end
