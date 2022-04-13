class NewDeveloperNotification < ApplicationNotification
  deliver_by :database
  deliver_by :email, mailer: "WelcomeMailer", method: :welcome_email

  param :developer

  def title
    t "notifications.new_developer", developer: developer.name
  end

  def url
    developer_path(developer)
  end

  def developer
    params[:developer]
  end
end
