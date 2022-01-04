module NotificationsHelper
  extend ActiveSupport::Concern

  included do
    def last_message_notification
      Notification.where(type: NewMessageNotification.to_s).last
    end
  end
end
