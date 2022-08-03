module Developers
  class InvisiblizeNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "InvisiblizeMailer", method: :to_developer

    param :developer, :message, :next_steps

    def title
      t("notifications.developers.invisiblize_notification.title")
    end

    def url
      edit_developer_url(developer)
    end

    def developer
      params[:developer]
    end

    def message
      params[:message]
    end

    def next_steps
      params[:next_steps]
    end
  end
end
