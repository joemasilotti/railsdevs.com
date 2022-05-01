class PotentialHireNotification < Noticed::Base
  deliver_by :database, if: :still_needed?
  deliver_by :email, mailer: "AdminMailer", method: :potential_hire, if: :still_needed?

  param :developer

  def title
    t "notifications.potential_hire",
      developer: developer.name
  end

  def developer
    params[:developer]
  end

  def url
    developer_path(developer)
  end

  def still_needed?
    return false if developer.notifications_as_subject
      .where(created_at: 7.days.ago..5.minutes.ago,
        type: "PotentialHireNotification").exists?

    !developer.new_developer_account?
  end
end
