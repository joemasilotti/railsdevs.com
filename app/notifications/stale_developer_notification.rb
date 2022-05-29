class StaleDeveloperNotification < ApplicationNotification
  deliver_by :database, if: :deliver_notification?
  deliver_by :email, mailer: "DeveloperMailer", method: :stale, if: :deliver_notification?

  param :developer

  def developer
    params[:developer]
  end

  def title
    t("notifications.stale_developer_profile")
  end

  def url
    edit_developer_path(developer)
  end

  def deliver_notification?
    developer.send_stale_notification?
  end
end
