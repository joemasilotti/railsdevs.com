class PotentialHireNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer", method: :potential_hire

  param :developer

  def title
    t("notifications.potential_hire", developer: developer.name)
  end

  def developer
    params[:developer]
  end

  def url
    admin_developer_conversations_path(developer)
  end
end
