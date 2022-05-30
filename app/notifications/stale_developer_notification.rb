class StaleDeveloperNotification < ApplicationNotification
  deliver_by :database, if: :deliver_notification?
  deliver_by :email, mailer: "DeveloperMailer", method: :stale, if: :deliver_notification?

  param :developer

  def developer
    params[:developer]
  end

  def title
    t("notifications.profile_reminder")
  end

  def url
    edit_developer_path(developer, anchor: "notifications")
  end

  def deliver_notification?
    developer.profile_reminder_notifications?
  end
end
