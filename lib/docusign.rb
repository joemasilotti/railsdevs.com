# frozen_string_literal: true

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Docusign < OmniAuth::Strategies::OAuth2
      # The name of the strategy, used in config/initializer/omniauth.rb
      option :name, "docusign"

      # These are called after the OAuth2 login authentication has succeeded and are part of the DocuSign callback response message:
      # transforms the DocuSign login response from the raw_info https://github.com/omniauth/omniauth/wiki/Strategy-Contribution-Guide#defining-the-callback-phase
      # into the standardized schema required by OmniAuth https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema
      # and gets exposed through the "request.env[omniauth.auth]" to the SessionController#create
      uid { raw_info["sub"] }

      info do
        {
          name: raw_info["name"],
          email: raw_info["email"],
          first_name: raw_info["given_name"],
          last_name: raw_info["family_name"]
        }
      end

      extra do
        {
          sub: raw_info["sub"],
          account_id: @account["account_id"],
          account_name: @account["account_name"],
          base_uri: @account["base_uri"]
        }
      end

      private

      # @returns a Hash with the keys:
      # sub, name, given_name, family_name, created, email, accounts: [account_id, is_default, account_name, base_uri]
      def raw_info
        return @raw_info if @raw_info

        @raw_info = access_token.get(options.client_options.user_info_url.to_s).parsed || {}
        fetch_account(@raw_info["accounts"]) if @raw_info.present?
        @raw_info
      end

      # @param items is an array of Hash'es that has the keys: account_id, is_default, account_name, base_uri
      def fetch_account(items)
        @account = if options.target_account_id
          items.find { |item| item["account_id"] == options.target_account_id }
        else
          items.find { |item| item["is_default"] }
        end

        raise %(Could not find account information for the user in the "accounts" of raw_info: #{@raw_info}) if @account.blank?
      end
    end
  end
end
