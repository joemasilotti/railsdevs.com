require 'uri'
require 'net/http'
require 'json'

module DeveloperExternalProfiles
  class LinkedinProfile

    class LinkedInAPIError < StandardError
      attr_reader :status, :message
    
      def initialize(status, message)
        @status = status
        @message = message
        super("API error: #{status} - #{message}")
      end
    end

    def initialize
      @api_key = api_key
      @endpoint = endpoint
    end

    def get_profile(url)
      header_hash = {'Authorization' => 'Bearer ' + @api_key}
      params = {
        'url' => url,
        'fallback_to_cache' => 'on-error',
        'use_cache' => 'if-present'
      }

      uri = URI(@endpoint)
      uri.query = URI.encode_www_form(params)

      begin
        response = Net::HTTP.get_response(uri, header_hash)

        if response.code.to_i == 200
          parse_json_response(response.body)
        else
          raise LinkedInAPIError.new("API error: #{response.code} - #{response.body}")
        end
      rescue RestClient::ExceptionWithResponse => e
        raise LinkedInAPIError.new("API error: #{e.response.code} - #{e.response.body}")
      end
    end


    private

    def parse_json_response(response_body)
      response_hash = JSON.parse(response_body)
      begin
        # Attempt to access the first company name in the experiences array
        current_experience = response_hash["experiences"][0]
      rescue NoMethodError
        current_experience = nil
      end
    rescue JSON::ParserError => e
      raise LinkedInAPIError.new("JSON parsing error: #{e.message}")
    end

    def api_key
      Rails.application.credentials.proxycurl_api_key
    end

    def endpoint
      "https://nubela.co/proxycurl/api/v2/linkedin"
    end

  end
end