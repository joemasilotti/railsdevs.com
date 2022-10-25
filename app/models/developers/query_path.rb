module Developers
  class QueryPath
    include UrlHelpersWithDefaultUrlOptions

    private attr_reader :paywalled_search_results

    def initialize(paywalled_search_results: Feature.enabled?(:paywalled_search_results))
      @paywalled_search_results = paywalled_search_results
    end

    def self.all
      new.all
    end

    def all
      paths = []

      RoleLevel::TYPES.each do |role_level|
        paths += build_paths(role_level:)

        unless paywalled_search_results
          top_countries.each do |country|
            paths += build_paths(role_level:, country:)
          end
        end
      end

      unless paywalled_search_results
        top_countries.each do |country|
          paths += build_paths(country:)
        end
      end

      paths
    end

    private

    def top_countries
      @top_countries ||= Location.top_countries
    end

    def build_paths(role_level: nil, country: nil)
      [
        build_path(role_level:, country:),
        build_path(role_level:, country:, freelance: true)
      ]
    end

    def build_path(role_level: nil, country: nil, freelance: false)
      options = {}
      options[:role_levels] = [role_level] if role_level.present?
      options[:countries] = [country] if country.present?
      options[:role_types] = [:part_time_contract, :full_time_contract] if freelance
      developers_path(options)
    end
  end
end
