module Admin
  module Businesses
    class HiringInvoiceRequestNotification < ApplicationNotification
      deliver_by :database
      deliver_by :email, mailer: "AdminMailer", method: :businesses_hiring_invoice_request

      param :hiring_invoice_request

      def title
        t("notifications.admin.businesses.hiring_invoice_request_notification.title", business: hiring_invoice_request.business.name)
      end

      def url
        admin_businesses_hiring_invoice_request_path(hiring_invoice_request)
      end

      def hiring_invoice_request
        params[:hiring_invoice_request]
      end
    end
  end
end
