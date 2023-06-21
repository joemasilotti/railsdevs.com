class EmailDigests::LinkedinProfiles
  def send_digest
    last_month = Date.current.last_month
    last_month = last_month.beginning_of_month..last_month.end_of_month
    linkedin_profiles = Developers::ExternalProfile
      .where(updated_at: last_month)
      .where.not(data: {})
      .includes(:developer)

    return if linkedin_profiles.empty?

    linkedin_profiles = linkedin_profiles.to_a
    AdminMailer.with(linkedin_profiles:).linkedin_weekly_profiles.deliver_later
  end
end
