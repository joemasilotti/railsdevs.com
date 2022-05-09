module Businesses
  module Notifications
    def save_and_notify
      if save
        send_admin_notification
        true
      end
    end

    private

    def send_admin_notification
      NewBusinessNotification.with(business: self).deliver_later(User.admin)
    end
  end
end
