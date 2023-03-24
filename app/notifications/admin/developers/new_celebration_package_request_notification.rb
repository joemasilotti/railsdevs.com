module Admin
  module Developers
    class NewCelebrationPackageRequestNotification < ApplicationNotification
      deliver_by :database
      deliver_by :email, mailer: "AdminMailer", method: :developers_celebration_package_request

      param :form

      def title
        t("notifications.admin.developers.celebration_package_request.title", developer: form.developer.name)
      end

      def url
        admin_developers_celebration_package_requests_path(form)
      end

      def form
        params[:form]
      end
    end
  end
end
