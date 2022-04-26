module NotificationsHelper
  extend ActiveSupport::Concern

  included do
    def last_message_notification
      Notification.where(type: NewMessageNotification.to_s).last
    end

    def create_message_and_notification!(developer:, business:, conversation: nil, body: "Hello!")
      message = Message.create!(developer:, business:, sender: developer, body:)
      conversation ||= message.conversation
      NewMessageNotification.with(message:, conversation:).deliver(message.recipient.user)
      message
    end
  end
end
