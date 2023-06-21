namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles"
  task fetch_profiles: :environment do
    Developers::ExternalProfiles::LinkedinProfileFetcher.new.developer_profiles
  end

  desc "Email LinkedIn updates"
  task send_digest: :environment do
    EmailDigests::LinkedinProfiles.new.send_digest
  end
end
