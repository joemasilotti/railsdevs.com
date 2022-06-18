module Developers
  class Title
    private attr_reader :query

    def initialize(query)
      @query = query
    end

    def title
      components = []
      components << "Hire"
      components << role_level if role_level
      components << "freelance" if freelance?
      components << "Ruby on Rails developers"
      components << "in #{country}" if country
      components.join(" ")
    end

    private

    def role_level
      if query.role_levels.one?
        if query.role_levels.first == :mid
          "mid-level"
        elsif query.role_levels.first == :c_level
          "C-level"
        else
          query.role_levels.first
        end
      end
    end

    def freelance?
      query.role_types.include?(:part_time_contract) &&
        query.role_types.include?(:full_time_contract) &&
        !query.role_types.include?(:full_time_employment)
    end

    def country
      if query.countries.one?
        query.countries.first
      end
    end
  end
end
