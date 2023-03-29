namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles"
  task fetch_profiles: :environment do
    api = DeveloperExternalProfiles::LinkedinProfile.new
    active_developer = Conversation.all.map(&:developer).uniq.first
    developer_external_profiles_list = []
    # active_developers.each do |developer|
    linkedin = active_developer.linkedin
    if !linkedin.blank?
      linkedin_url = "https://linkedin.com/in/" + linkedin + "/".to_s
      current_position = api.get_profile(linkedin_url)
      developer_external_profile = DeveloperExternalProfile.linkedin_developer(active_developer)
      developer_external_profile.data = current_position if !developer_external_profile.blank?
      if developer_external_profile.blank? || developer_external_profile&.data_changed?
        developer_external_profiles_list << {developer_id: active_developer.id, site: "linkedin", data: current_position}
      end
    end
    # end
    DeveloperExternalProfile.upsert_all(developer_external_profiles_list, unique_by: [:developer_id, :site]) if !developer_external_profiles_list.blank?
  end
end
