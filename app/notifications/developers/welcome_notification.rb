module Developers
  class WelcomeNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "DeveloperMailer", method: :welcome

    param :developer

    def title
      t("notifications.developers.welcome_notification.title")
    end

    def url
      developer_url(developer)
    end

    def developer
      params[:developer]
    end
  end
end
