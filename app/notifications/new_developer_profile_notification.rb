class NewDeveloperProfileNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer", method: :new_developer_profile

  param :developer

  def developer
    params[:developer]
  end
end
