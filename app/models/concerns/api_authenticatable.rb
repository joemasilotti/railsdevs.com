module APIAuthenticatable
  extend ActiveSupport::Concern

  included do
    has_secure_token :authentication_token

    def self.valid_credentials?(email, password)
      user = find_by(email:)
      user&.valid_password?(password) ? user : nil
    end
  end
end
