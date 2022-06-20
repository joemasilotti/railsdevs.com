module Developers
  class QueryComponent < ApplicationComponent
    attr_reader :query, :user, :form_id

    delegate :sort, :search_query, to: :query

    def initialize(query:, user:, form_id:)
      @query = query
      @user = user
      @form_id = form_id
    end

    def country_selected?(country_pair)
      query.countries.include?(country_pair.first)
    end

    def top_countries
      Location.top_countries.map { |k| [k, k] }
    end

    def countries
      Location.not_top_countries.map { |k| [k, k] }
    end

    def time_zone_selected?(time_zone_pair)
      query.utc_offsets.include?(time_zone_pair.first.to_f)
    end

    def time_zones
      @time_zones ||= utc_offsets.map do |utc_offset|
        [utc_offset, render(UTCOffsets::Component.new(utc_offset))]
      end
    end

    def role_type_selected?(role_type_pair)
      query.role_types.include?(role_type_pair.first)
    end

    def role_types
      # i18n-tasks-use t('activerecord.attributes.role_type.full_time_contract')
      # i18n-tasks-use t('activerecord.attributes.role_type.full_time_employment')
      # i18n-tasks-use t('activerecord.attributes.role_type.part_time_contract')
      RoleType::TYPES.map { |role| [role, RoleType.human_attribute_name(role)] }
    end

    def role_level_selected?(role_level_pair)
      query.role_levels.include?(role_level_pair.first)
    end

    def role_levels
      # i18n-tasks-use t('activerecord.attributes.role_level.c_level')
      # i18n-tasks-use t('activerecord.attributes.role_level.junior')
      # i18n-tasks-use t('activerecord.attributes.role_level.mid')
      # i18n-tasks-use t('activerecord.attributes.role_level.principal')
      # i18n-tasks-use t('activerecord.attributes.role_level.senior')
      RoleLevel::TYPES.map { |role| [role, RoleLevel.human_attribute_name(role)] }
    end

    def include_not_interested?
      query.include_not_interested
    end

    private

    def utc_offsets
      Location.order(:utc_offset).distinct.pluck(:utc_offset)
    end
  end
end
