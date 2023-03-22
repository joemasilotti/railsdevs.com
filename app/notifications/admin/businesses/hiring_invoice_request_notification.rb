module Admin
  module Businesses
    class HiringInvoiceRequestNotification < ApplicationNotification
      deliver_by :database
      deliver_by :email, mailer: "AdminMailer", method: :businesses_hiring_invoice_request

      param :form

      def title
        t("notifications.admin.businesses.hiring_invoice_request_notification.title", business: form.business.name)
      end

      def url
        admin_businesses_hiring_invoice_requests_path(form)
      end

      def form
        params[:form]
      end
    end
  end
end
