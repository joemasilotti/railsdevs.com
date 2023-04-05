namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles"
  task fetch_profiles: :environment do
    Developers::ExternalProfiles::LinkedinProfileFetcher.new.developer_profiles
  end

  desc "Email LinkedIn updates from past 7 days"
  task weekly_digest: :environment do
    EmailDigests::LinkedinProfiles.new.send_weekly_digest
  end
end
