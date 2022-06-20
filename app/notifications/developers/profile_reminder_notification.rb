module Developers
  class ProfileReminderNotification < ApplicationNotification
    deliver_by :database, if: :deliver_notification?
    deliver_by :email, mailer: "DeveloperMailer", method: :profile_reminder, if: :deliver_notification?

    param :developer

    def developer
      params[:developer]
    end

    def title
      t("notifications.developers.profile_reminder_notification.title")
    end

    def email_subject
      t("notifications.developers.profile_reminder_notification.email_subject")
    end

    def url
      edit_developer_url(developer, anchor: "notifications")
    end

    def deliver_notification?
      developer.profile_reminder_notifications?
    end
  end
end
