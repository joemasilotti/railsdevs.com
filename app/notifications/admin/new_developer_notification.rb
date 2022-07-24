module Admin
  class NewDeveloperNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :new_developer

    param :developer

    def title
      t("notifications.admin.new_developer_notification.title", developer: developer.name)
    end

    def email_subject
      t("notifications.admin.new_developer_notification.email_subject")
    end

    def url
      developer_url(developer)
    end

    def developer
      params[:developer]
    end
  end
end
