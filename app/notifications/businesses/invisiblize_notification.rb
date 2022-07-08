module Businesses
  class InvisiblizeNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "InvisiblizeMailer", method: :to_business

    param :business

    def title
      t("notifications.businesses.invisiblize_notification.title")
    end

    def url
      edit_business_url(business)
    end

    def business
      params[:business]
    end
  end
end
