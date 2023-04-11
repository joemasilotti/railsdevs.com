# frozen_string_literal: true

require "docusign"
# Defaults to STDOUT: https://github.com/omniauth/omniauth#logging
# Logs entries like:
# (docusign) Setup endpoint detected, running now.
# (docusign) Request phase initiated.
# (docusign) Callback phase initiated.
OmniAuth.config.logger = Rails.logger
OmniAuth.config.silence_get_warning = true

# https://github.com/omniauth/omniauth/wiki/FAQ#omniauthfailureendpoint-does-not-redirect-in-development-mode
# otherwise a callback exception like the following will not get caught:
# OmniAuth::Strategies::OAuth2::CallbackError (access_denied)
# GET "/auth/docusign/callback?error=access_denied&error_message=The%20user%20did%20not%20consent%20to%20connecting%20the%20application.&state=
# OmniAuth.config.failure_raise_out_environments = [] # defaults to: ['development']
OmniAuth.config.allowed_request_methods = %i[post get]
config = Rails.application.config
config.middleware.use OmniAuth::Builder do
  # OAuth2 login request configuration
  # OAuth2 login response callback message configuration is in OmniAuth::Strategies::Docusign in lib/docusign.rb
  provider :docusign, Rails.application.credentials.dig(:docusign, :integration_key), Rails.application.credentials.dig(:docusign, :secret_key), skip_code_challenge: true, setup: lambda { |env|
    strategy = env["omniauth.strategy"]

    strategy.options[:client_options].site = Rails.application.routes.url_helpers.root_url
    strategy.options[:prompt] = "login"
    strategy.options[:oauth_base_uri] = Rails.env.development? ? "https://account-d.docusign.com" : "https://account.docusign.com"
    strategy.options[:target_account_id] = false
    strategy.options[:allow_silent_authentication] = false
    strategy.options[:client_options].authorize_url = "#{strategy.options[:oauth_base_uri]}/oauth/auth"
    strategy.options[:client_options].user_info_url = "#{strategy.options[:oauth_base_uri]}/oauth/userinfo"
    strategy.options[:client_options].token_url = "#{strategy.options[:oauth_base_uri]}/oauth/token"
    unless strategy.options[:allow_silent_authentication]
      strategy.options[:authorize_params].prompt = strategy.options.prompt
    end

    strategy.options[:authorize_params].scope = "signature click.manage click.send"
  }
end
