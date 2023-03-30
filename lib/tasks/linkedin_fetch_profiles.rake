namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles"
  task fetch_profiles: :environment do
    DeveloperExternalProfiles::LinkedinProfileFetcher.new.conversion_developer_profiles
  end
end
