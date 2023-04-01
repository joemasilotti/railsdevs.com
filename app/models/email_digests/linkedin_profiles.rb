class EmailDigests::LinkedinProfiles
  def send_weekly_digest
    # return unless Time.current.monday?
    developer_external_profiles_records = []

    prev_7_days = 7.days.ago.beginning_of_day..1.day.ago.end_of_day
    developer_external_profiles = Developers::ExternalProfile.where(updated_at: prev_7_days).includes(:developer)
    return if developer_external_profiles.empty?

    developer_external_profiles.each do |developer_external_profile|
      developer_external_profiles_records << {
        id: developer_external_profile.developer.id,
        name: developer_external_profile.developer.name,
        linkedin: developer_external_profile.developer.linkedin,
        company: developer_external_profile.company(developer_external_profile.data)
      }
    end
    AdminMailer.with(developer_external_profiles_records:).linkedin_weekly_profiles.deliver_later
  end
end
