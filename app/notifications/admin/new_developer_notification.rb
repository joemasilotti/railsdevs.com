module Admin
  class NewDeveloperNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :new_developer_profile

    param :developer

    def title
      t("notifications.admin.new_developer_notification.title", developer: developer.name)
    end

    def url
      developer_path(developer)
    end

    def developer
      params[:developer]
    end
  end
end
