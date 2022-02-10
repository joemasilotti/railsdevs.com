module HasSocialProfiles
  extend ActiveSupport::Concern

  PREFIXES = {
    github: "github.com/",
    twitter: "twitter.com/",
    linkedin: "linkedin.com/in/"
  }

  included do
    before_save :normalize_github, if: :will_save_change_to_github?
    before_save :normalize_twitter, if: :will_save_change_to_twitter?
    before_save :normalize_linkedin, if: :will_save_change_to_linkedin?

    private

    PREFIXES.each do |handle, prefix|
      define_method "normalize_#{handle}" do
        send(handle)&.delete_prefix!(prefix)
        send(handle)&.delete_prefix!("http://#{prefix}")
        send(handle)&.delete_prefix!("https://#{prefix}")
        send(handle)&.delete_prefix!("http://www.#{prefix}")
        send(handle)&.delete_prefix!("https://www.#{prefix}")
      end
    end
  end
end
