module Businesses
  class WelcomeNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "BusinessMailer", method: :welcome

    param :business

    def title
      t("notifications.businesses.welcome.title", business: business.contact_name)
    end

    def url
      developers_url
    end

    def business
      params[:business]
    end
  end
end
