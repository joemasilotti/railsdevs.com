module Docusign
  module Sessionable
    extend ActiveSupport::Concern

    private

    def clear_ds_session
      session.delete :ds_expires_at
      session.delete :ds_user_name
      session.delete :ds_access_token
      session.delete :ds_account_id
      session.delete :ds_account_name
      session.delete :ds_base_path
      session.delete "omniauth.state"
      session.delete "omniauth.params"
      session.delete "omniauth.origin"
      session.delete :envelope_id
      session.delete :envelope_documents
      session.delete :template_id
      session.delete :eg
      session.delete :manifest
      session.delete :status_cfr
      cookies.delete :ds_pending_envelope_id
    end

    def decrypted_envelope_id(encrypted_envelope_id)
      ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31]).decrypt_and_verify(encrypted_envelope_id)
    rescue ActiveSupport::MessageEncryptor::InvalidMessage
      nil
    end
  end
end
