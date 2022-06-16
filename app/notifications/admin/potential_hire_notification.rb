module Admin
  class PotentialHireNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :potential_hire

    param :developer

    def title
      t("notifications.admin.potential_hire_notification.title", developer: developer.name)
    end

    def email_subject
      t("notifications.admin.potential_hire_notification.email_subject")
    end

    def url
      admin_developer_conversations_url(developer)
    end

    def developer
      params[:developer]
    end
  end
end
