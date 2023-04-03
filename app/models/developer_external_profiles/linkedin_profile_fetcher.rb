module DeveloperExternalProfiles
  class LinkedinProfileFetcher
    def developer_profiles
      developer_external_profiles_list = []
      developers_with_linked_in_profiles.each do |developer|
        response = fetch_linkedin_profile(developer.linkedin)
        external_profile_record = external_profile(developer, response)
        developer_external_profiles_list << external_profile_record if external_profile_record.present?
      end

      upsert_external_profiles(developer_external_profiles_list)
    end

    def external_profile(developer, response)
      if response[:error]
        {developer_id: developer.id, site: "linkedin", data: {}, error: response[:error]}
      else
        external_profile = Developers::ExternalProfile.linkedin_developer(developer)
        external_profile.data = response[:data] unless external_profile.blank?
        if external_profile.blank? || external_profile.data_changed?
          {developer_id: developer.id, site: "linkedin", data: response[:data], error: nil}
        end
      end
    end

    def upsert_external_profiles(profiles)
      unless profiles.empty?
        Developers::ExternalProfile.upsert_all(profiles, unique_by: [:developer_id, :site])
      end
    end

    private

    def developers_with_linked_in_profiles
      Developer.where.not(linkedin: [nil, ""]).distinct
    end

    def fetch_linkedin_profile(linkedin_id)
      linkedin_url = "https://linkedin.com/in/#{linkedin_id}/"
      get_profile(linkedin_url)
    end

    def get_profile(linkedin_url)
      api = DeveloperExternalProfiles::Linkedin.new
      api.get_profile(linkedin_url)
    end
  end
end
