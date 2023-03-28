module Developers
  module CelebrationPackageRequests
    module Notifications
      def save_and_notify
        if save
          send_admin_notification
          true
        end
      end

      def send_admin_notification
        Admin::Developers::NewCelebrationPackageRequestNotification.with(celebration_package_request: self).deliver_later(User.admin)
      end
    end
  end
end
