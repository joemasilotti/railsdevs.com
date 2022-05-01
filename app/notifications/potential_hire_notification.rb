class PotentialHireNotification < Noticed::Base
  deliver_by :database, if: :still_needed?
  deliver_by :email, mailer: "AdminMailer", method: :potential_hire, delay: 30.minutes, if: :still_needed?

  REASONS = %i[saved_change_to_full_time_employment saved_change_to_search_status].freeze

  param :developer
  param :reason

  def title
    t "notifications.potential_hire",
      developer: developer.name
  end

  def developer
    params[:developer]
  end

  def reason
    params[:reason]
  end

  def url
    developer_path(developer)
  end

  def still_needed?
    return false if developer.notifications_as_subject
                             .where(created_at: 1.hour.ago..3.days.ago,
                                    type: 'PotentialHireNotification').exists?

    case reason
    when :search_status
      Developer::UNAVAILABLE_STATUSES.include? developer.search_status
    when :full_time_employment
      !developer.role_type.full_time_employment
    end
  end
end
