module Businesses
  module Notifications
    def save_and_notify
      if save
        send_admin_notification
        true
      end
    end

    def invisiblize_and_notify!
      update(invisible: true)
      send_invisiblize_notification
    end

    private

    def send_admin_notification
      Admin::NewBusinessNotification.with(business: self).deliver_later(User.admin)
    end

    def send_invisiblize_notification
      InvisiblizeNotification.with(business: self).deliver_later(user)
    end
  end
end
