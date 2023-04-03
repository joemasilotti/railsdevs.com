require "faraday"
require "json"

module DeveloperExternalProfiles
  class Linkedin
    def initialize
      @api_key = api_key
      @endpoint = endpoint
    end

    def get_profile(url)
      params = {
        "url" => url,
        "fallback_to_cache" => "on-error",
        "use_cache" => "if-present"
      }

      conn = Faraday.new(@endpoint) do |faraday|
        faraday.headers["Authorization"] = "Bearer #{@api_key}"
        faraday.adapter Faraday.default_adapter
      end

      begin
        response = conn.get("", params)

        if response.status.to_i == 200
          parse_json_response(response.body)
        else
          Honeybadger.notify(
            error_class: "LinkedIn API Error",
            error_message: "API Error: #{response.status} - #{response.body}",
            context: {
              message: "Error occurred while fetching data from LinkedIn API",
              developer: "Developer Linkedin URL - #{url}",
              linkedin_api_response: response&.body
            }
          )
          {error: "API Error: #{response.status} - #{response.body}"}
        end
      rescue Faraday::Error => e
        Honeybadger.notify(e, context: {
          message: "Error occurred while fetching data from LinkedIn API - #{e.message}",
          developer: "Developer Linkedin URL - #{url}",
          linkedin_api_response: response&.body
        })
        {error: "Exception occurred: #{e.message}"}
      end
    end

    private

    def parse_json_response(response_body)
      response_hash = JSON.parse(response_body)
      begin
        # Attempt to access the first company name in the experiences array
        {data: response_hash["experiences"][0]}
      rescue NoMethodError
        {error: "JSON Parsing Error: #{e.message}"}
      end
    rescue JSON::ParserError => e
      Honeybadger.notify(e, context: {
        message: "Error occurred while parsing JSON response from LinkedIn API - #{e.message}",
        linkedin_api_response: response_body
      })
      {error: "JSON Parsing Error: #{e.message}"}
    end

    def api_key
      Rails.application.credentials.proxycurl_api_key
    end

    def endpoint
      "https://nubela.co/proxycurl/api/v2/linkedin"
    end
  end
end
