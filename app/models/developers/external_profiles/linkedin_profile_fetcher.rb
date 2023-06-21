module Developers::ExternalProfiles
  class LinkedinProfileFetcher
    def developer_profiles
      profiles = []
      developers = developers_with_linkedin_profiles
      Rails.logger.info "Fetching #{developers.count} #{"LinkedIn profile".pluralize(developers.count)}..."

      developers.find_each.with_index do |developer, index|
        response = fetch_linkedin_profile(developer.linkedin)
        record = external_profile(developer, response)
        profiles << record if record.present?

        developers_left = developers.count - index - 1
        Rails.logger.info "#{developers_left} #{"profile".pluralize(developers_left)} left"
      end

      upsert_external_profiles(profiles)
    end

    def external_profile(developer, response)
      if response.error?
        {developer_id: developer.id, site: "linkedin", data: {}, error: response.error}
      else
        external_profile = Developers::ExternalProfile.linkedin_developer(developer)
        external_profile.data = response.data unless external_profile.blank?
        if external_profile.blank? || external_profile.data_changed?
          {developer_id: developer.id, site: "linkedin", data: response.data, error: nil}
        end
      end
    end

    def upsert_external_profiles(profiles)
      unless profiles.empty?
        Developers::ExternalProfile.upsert_all(profiles, unique_by: [:developer_id, :site])
      end
    end

    private

    def developers_with_linkedin_profiles
      Developer.where.not(linkedin: [nil, ""])
    end

    def fetch_linkedin_profile(linkedin_id)
      linkedin_url = "https://linkedin.com/in/#{linkedin_id}/"
      api_response = Developers::ExternalProfiles::Linkedin.new.get_profile(linkedin_url)
      Developers::ExternalProfiles::Linkedin::Response.new(data: api_response[:data], error: api_response[:error])
    end
  end
end
