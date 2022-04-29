module APIAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_save :ensure_authentication_token

    def self.valid_credentials?(email, password)
      user = find_by(email:)
      user&.valid_password?(password) ? user : nil
    end

    def ensure_authentication_token
      if authentication_token.blank?
        self.authentication_token = generate_authentication_token
      end
    end

    private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless self.class.where(authentication_token: token).first
      end
    end
  end
end
