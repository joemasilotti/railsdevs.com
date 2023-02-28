module Businesses
  class WelcomeNotification < ApplicationNotification
    deliver_by :email, mailer: "BusinessMailer", method: :welcome

    param :business

    def url
      developers_url
    end

    def business
      params[:business]
    end
  end
end
