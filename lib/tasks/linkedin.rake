namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles"
  task fetch_profiles: :environment do
    DeveloperExternalProfiles::LinkedinProfileFetcher.new.conversation_developer_profiles
  end

  desc "Email linkedin updated in past 7 days"
  task weekly_digest: :environment do
    EmailDigests::LinkedinProfiles.new.send_weekly_digest
  end
end
