namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles"
  task fetch_profiles: :environment do
    api = DeveloperExternalProfiles::LinkedinProfile.new
    developer_external_profiles_list = []

    Conversation.includes(:developer).where.not(developers: {linkedin: nil}).map(&:developer).uniq.each do |developer|
      linkedin_url = "https://linkedin.com/in/#{developer.linkedin}/"
      response = api.get_profile(linkedin_url)

      if response[:error]
        developer_external_profiles_list << {developer_id: developer.id, site: "linkedin", data: nil, error: response[:error]}
      else
        developer_external_profile = DeveloperExternalProfile.linkedin_developer(developer)
        developer_external_profile.data = response[:data] unless developer_external_profile.blank?
        if developer_external_profile.blank? || developer_external_profile.data_changed?
          developer_external_profiles_list << {developer_id: developer.id, site: "linkedin", data: response[:data], error: nil}
        end
      end
    end

    DeveloperExternalProfile.upsert_all(developer_external_profiles_list, unique_by: [:developer_id, :site]) unless developer_external_profiles_list.empty?
  end
end
