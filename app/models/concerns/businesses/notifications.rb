module Businesses
  module Notifications
    def save_and_notify
      if save
        send_admin_notification
        send_welcome_email
        true
      end
    end

    private

    def send_admin_notification
      NewBusinessNotification.with(business: self).deliver_later(User.admin)
    end

    def send_welcome_email
      BusinessMailer.with(business: self).welcome_email.deliver_later
    end
  end
end
