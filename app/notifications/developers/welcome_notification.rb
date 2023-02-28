module Developers
  class WelcomeNotification < ApplicationNotification
    deliver_by :email, mailer: "DeveloperMailer", method: :welcome

    param :developer

    def url
      developer_url(developer)
    end

    def developer
      params[:developer]
    end
  end
end
