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
        t("notifications.admin.affiliates.registration_notification.title")
      end

      def url
        "mailto:#{user.email}"
      end
    end
  end
end
