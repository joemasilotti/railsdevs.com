module Admin
  module Developers
    class NewCelebrationPackageRequestNotification < ApplicationNotification
      deliver_by :database
      deliver_by :email, mailer: "AdminMailer", method: :developers_celebration_package_request

      param :celebration_package_request

      def title
        t("notifications.admin.developers.celebration_package_request.title", developer: celebration_package_request.developer.name)
      end

      def url
        admin_developers_celebration_package_request_path(celebration_package_request)
      end

      def celebration_package_request
        params[:celebration_package_request]
      end
    end
  end
end
