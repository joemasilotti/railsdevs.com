class EmailDigests::LinkedinProfiles
  def send_weekly_digest
    prev_7_days = 7.days.ago.beginning_of_day..1.day.ago.end_of_day
    linkedin_profiles = Developers::ExternalProfile.where(updated_at: prev_7_days).where.not(data: {}).includes(:developer)
    return if linkedin_profiles.empty?
    linkedin_profiles = linkedin_profiles.to_a
    AdminMailer.with(linkedin_profiles:).linkedin_weekly_profiles.deliver_later
  end
end
