class WelcomeDeveloperNotification < ApplicationNotification
  deliver_by :database
  deliver_by :email, mailer: "DeveloperMailer", method: :welcome

  param :developer

  def developer
    params[:developer]
  end

  def title
    t("notifications.welcome_developer_notification.title")
  end

  def url
    root_url
  end
end
