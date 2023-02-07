module Hire
  module Notifications
    def save_and_notify
      if save
        send_admin_notification
        true
      end
    end

    def send_admin_notification
      Admin::NewHireFormNotification.with(form: self).deliver_later(User.admin)
    end
  end
end
