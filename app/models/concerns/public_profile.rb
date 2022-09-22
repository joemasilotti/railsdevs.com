module PublicProfile
  extend ActiveSupport::Concern

  included do
    include UrlHelpersWithDefaultUrlOptions
  end

  def share_url
    update_public_profile_key if public_profile_key.blank?
    polymorphic_url(self, key: public_profile_key)
  end

  def valid_public_profile_access?(resource, profile_key)
    resource&.public_profile_key == profile_key && resource.public_profile_key.present?
  end

  private

  def update_public_profile_key
    update!(public_profile_key: generate_token)
  end

  def generate_token
    loop do
      public_key = SecureRandom.hex(4)
      break public_key unless self.class.find_by(public_profile_key: public_key)
    end
  end
end
