namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles"
  task fetch_profiles: :environment do
    # Only fetch profiles once per month, on the 21st.
    return unless Date.current.day == 21

    Developers::ExternalProfiles::LinkedinProfileFetcher.new.developer_profiles
  end

  desc "Email LinkedIn updates"
  task send_digest: :environment do
    EmailDigests::LinkedinProfiles.new.send_digest
  end
end
