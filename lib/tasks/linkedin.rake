namespace :linkedin do
  desc "Fetch and parse LinkedIn profiles, then email updates"
  task fetch_and_send_profiles: :environment do
    # Fetch LinkedIn profile details using ProxyCurl API
    Developers::ExternalProfiles::LinkedinProfileFetcher.new.developer_profiles
    Rails.logger.info "LinkedIn profiles fetched and parsed for developers."

    # Send list of LinkedIn profiles updated in last one month
    EmailDigests::LinkedinProfiles.new.send_digest
    Rails.logger.info "Email digest of LinkedIn profiles sent."
  end
end
