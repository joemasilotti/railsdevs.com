module Developers
  class Title
    private attr_reader :query

    def initialize(query)
      @query = query
    end

    def title
      components = []

      # i18n-tasks-use t("developers.title.hire")
      components << i18n("hire")

      components << role_level if role_level

      # i18n-tasks-use t("developers.title.freelance")
      components << i18n("freelance") if freelance?

      # i18n-tasks-use t("developers.title.ruby_on_rails_developers")
      components << i18n("ruby_on_rails_developers")

      # i18n-tasks-use t("developers.title.in_country")
      components << i18n("in_country", country:) if country

      components.join(" ")
    end

    private

    def i18n(key, options = {})
      I18n.t(key, **options.merge(scope: "developers.title"))
    end

    def role_level
      if query.role_levels.one?
        role = query.role_levels.first
        scope = [:activerecord, :attributes, :role_level]
        I18n.t(role, scope:, default: role.to_s.humanize).downcase
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
