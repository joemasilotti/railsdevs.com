class InvisiblizeDeveloperNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "DeveloperMailer", method: :flagged

  param :developer

  def developer_profile_url
    developer_path(developer)
  end

  def home_url
    root_path
  end

  def developer
    params[:developer]
  end
end
