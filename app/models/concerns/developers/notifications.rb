module Developers
  module Notifications
    def save_and_notify
      if save
        send_admin_notification
        send_welcome_email
        true
      end
    end

    def invisiblize_and_notify!
      invisible!
      send_invisiblize_notification
    end

    private

    def send_admin_notification
      NewDeveloperProfileNotification.with(developer: self).deliver_later(User.admin)
    end

    def send_welcome_email
      DeveloperMailer.with(developer: self).welcome_email.deliver_later
    end

    def send_invisiblize_notification
      InvisiblizeDeveloperNotification.with(developer: self).deliver_later(user)
    end
  end
end
