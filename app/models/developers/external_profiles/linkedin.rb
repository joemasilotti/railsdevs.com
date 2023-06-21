module Developers::ExternalProfiles
  class Linkedin
    class Response
      attr_reader :error, :data

      def initialize(data: nil, error: nil)
        @data = data
        @error = error
      end

      def error?
        error.present?
      end
    end

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
        faraday.adapter(Faraday.default_adapter)
        faraday.response(:json)
      end

      begin
        response = conn.get("", params)
        if response.success?
          parse_json_response(response.body)
        else
          {error: "API Error: #{response.status} - #{response.body}"}
        end
      rescue Faraday::Error => e
        {error: "Exception occurred: #{e.message}"}
      end
    end

    private

    def parse_json_response(response_body)
      # Attempt to access the first company name in the experiences array
      {data: response_body["experiences"][0]}
    rescue JSON::ParserError, NoMethodError => e
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
