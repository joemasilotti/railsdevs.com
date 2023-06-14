module Messages
  module Notifications
    def save_and_notify(cold_message: false)
      if save
        send_recipient_notification
        send_first_message_email if first_message?
        send_admin_notification if cold_message
        schedule_celebration_promotion if first_reply?
        update_developer_response_rate if cold_message
        true
      end
    end

    private

    def send_recipient_notification
      NewMessageNotification.with(message: self, conversation:).deliver_later(recipient.user)
    end

    def send_admin_notification
      Admin::NewConversationNotification.with(conversation:).deliver_later(User.admin)
    end

    def send_first_message_email
      DeveloperMailer.with(developer: conversation.developer).first_message.deliver_later
    end

    def schedule_celebration_promotion
      wait = Rails.configuration.deliver_celebration_promotion_after
      DeveloperMailer.with(conversation: conversation).celebration_promotion.deliver_later(wait:)
    end

    def update_developer_response_rate
      wait = Rails.application.config.developer_response_grace_period
      UpdateDeveloperResponseRateJob.set(wait:).perform_later(developer.id)
    end

    def first_message?
      Message.first_message?(conversation.developer)
    end

    def first_reply?
      conversation.first_reply?(conversation.developer)
    end
  end
end
