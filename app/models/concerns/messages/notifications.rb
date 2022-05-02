module Messages
  module Notifications
    def save_and_notify(cold_message: false)
      if save
        send_recipient_notification
        send_admin_notification if cold_message
        true
      end
    end

    private

    def send_recipient_notification
      NewMessageNotification.with(message: self, conversation:).deliver_later(recipient.user)
    end

    def send_admin_notification
      NewConversationNotification.with(conversation: self).deliver_later(User.admin)
    end
  end
end
