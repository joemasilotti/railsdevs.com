module Admin
  module Affiliates
    class RegistrationNotification < ApplicationNotification
      deliver_by :database
      deliver_by :email, mailer: "AdminMailer", method: :affiliates_registration

      param :user

      def user
        params[:user]
      end

      def title
        t("notifications.admin.affiliates.registration_notification.title", email: user.email)
      end

      def url
        root_path
      end
    end
  end
end
