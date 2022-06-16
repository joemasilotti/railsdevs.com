module Admin
  class NewBusinessNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :new_business

    param :business

    def title
      t("notifications.admin.new_business_notification.title", business: business.contact_name)
    end

    def email_subject
      t("notifications.admin.new_business_notification.email_subject", business: business.contact_name)
    end

    def url
      business_url(business)
    end

    def business
      params[:business]
    end
  end
end
