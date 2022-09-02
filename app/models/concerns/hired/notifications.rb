module Hired
  module Notifications
    def save_and_notify
      if save
        send_admin_notification
        true
      end
    end

    def send_admin_notification
    end
  end
end