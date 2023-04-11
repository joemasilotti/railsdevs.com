class Docusign::SessionsController < ApplicationController
  include Docusign::Sessionable

  # GET /auth/docusign/callback
  before_action :clear_ds_session, only: :new

  def new
    if auth_hash&.credentials&.token
      store_auth_hash_from_docusign_callback
      redirect_url = Docusign::EmbeddedSigningService.new({
        account_id: session[:ds_account_id],
        base_path: session[:ds_base_path],
        access_token: session[:ds_access_token],
        signer_email: current_user.email,
        signer_name: session[:ds_user_name] || current_user.name,
        ds_ping_url: Rails.application.routes.url_helpers.root_url,
        signer_client_id: 1000,
        cookies:
      }).worker
      redirect_to redirect_url, allow_other_host: true
    else
      redirect_to "/auth/docusign"
    end
  rescue DocuSign_eSign::ApiError => e
    flash[:alert] = "Docusign Api Error: #{e}. Please try again later."
    redirect_to new_hiring_agreement_signature_path
  end

  def store_auth_hash_from_docusign_callback
    session[:ds_expires_at] = auth_hash.credentials["expires_at"]
    session[:ds_user_name] = auth_hash.info.name
    session[:ds_access_token] = auth_hash.credentials.token
    session[:ds_account_id] = auth_hash.extra.account_id
    session[:ds_account_name] = auth_hash.extra.account_name
    session[:ds_base_path] = auth_hash.extra.base_uri
  end

  # returns hash with key structure of:
  # provider
  # uid
  # info: [name, email, first_name, last_name]
  # credentials: [token, refresh_token, expires_at, expires]
  # extra: [sub, account_id, account_name, base_uri]
  def auth_hash
    @auth_hash ||= request.env["omniauth.auth"]
  end
end
