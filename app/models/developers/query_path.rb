module Developers
  class QueryPath
    include UrlHelpersWithDefaultUrlOptions

    def self.all
      new.all
    end

    def all
      paths = []

      RoleLevel::TYPES.each do |role_level|
        paths << build_path(role_level:)
        paths << build_path(role_level:, freelance: true)

        top_countries.each do |country|
          paths << build_path(role_level:, country:)
          paths << build_path(role_level:, country:, freelance: true)
        end
      end

      top_countries.each do |country|
        paths << build_path(country:)
        paths << build_path(country:, freelance: true)
      end

      paths
    end

    private

    def top_countries
      @top_countries ||= Location.top_countries
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
