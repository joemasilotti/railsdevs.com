#require_relative '../../app/models/developer_external_profiles/linkedin_profile'

namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles"
  task fetch_profiles: :environment do
    api = DeveloperExternalProfiles::LinkedinProfile.new
    active_developer = Developer.last

    #active_developers.each do |developer|
      linkedin = active_developer.linkedin
      if !linkedin.blank?
        linkedin_url = "https://linkedin.com/in/"+linkedin+"/".to_s
        puts linkedin_url
        current_position = api.get_profile(linkedin_url)
        puts JSON.pretty_generate(current_position)
      end
   # end
  end
end