class EmailDigests::LinkedinProfiles
  def send_digest
    last_30_days = 30.days.ago..Time.now
    linkedin_profiles = Developers::ExternalProfile
      .where(updated_at: last_30_days)
      .where.not(data: {})
      .includes(:developer)

    return if linkedin_profiles.empty?

    linkedin_profiles = linkedin_profiles.to_a
    AdminMailer.with(linkedin_profiles:).linkedin_profiles.deliver_later
  end
end
