module Businesses
  module Notifications
    def save_and_notify
      if save
        send_admin_notification
        send_welcome_notification if Feature.enabled?(:business_welcome_email)
        true
      end
    end

    def invisiblize_and_notify!
      update(invisible: true)
      send_invisiblize_notification
    end

    private

    def send_welcome_notification
      WelcomeNotification.with(business: self).deliver_later(user)
    end

    def send_admin_notification
      Admin::NewBusinessNotification.with(business: self).deliver_later(User.admin)
    end

    def send_invisiblize_notification
      InvisiblizeNotification.with(business: self).deliver_later(user)
    end
  end
end
