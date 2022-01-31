class NewDeveloperProfileNotification < ApplicationNotification
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer", method: :new_developer_profile

  param :developer

  def title
    t "notifications.new_developer_profile", developer: developer.name
  end

  def url
    developer_path(developer)
  end

  def developer
    params[:developer]
  end
end
