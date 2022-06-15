module Developers
  class InvisiblizeNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "DeveloperMailer", method: :invisiblize

    param :developer

    def title
      t("notifications.developers.invisiblize_notification.title")
    end

    def url
      edit_developer_url(developer)
    end

    def developer
      params[:developer]
    end
  end
end
