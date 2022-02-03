module OpenStartup
  class Visitors
    def self.fetch
      new.fetch
    end

    def fetch
      client.aggregations.list(
        entity_id:,
        entity: "pageview",
        aggregates: "visits",
        date_from: 30.days.ago
      ).first["visits"]
    end

    private

    def client
      Fathom::Client.new(api_key:)
    end

    def api_key
      Rails.application.credentials.fathom.api_key
    end

    def entity_id
      Rails.application.config.fathom
    end
  end
end
