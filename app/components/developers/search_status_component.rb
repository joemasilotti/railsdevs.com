module Developers
  class SearchStatusComponent < ApplicationComponent
    attr_reader :developer

    delegate :actively_looking?, :open?, to: :developer

    def initialize(developer)
      @developer = developer
    end

    def render?
      developer.search_status.present?
    end

    def humanize(enum_value)
      # i18n-tasks-use t('developers.search_status.actively_looking')
      # i18n-tasks-use t('developers.search_status.not_interested')
      # i18n-tasks-use t('developers.search_status.open')
      Developer.human_attribute_name "search_status.#{enum_value}"
    end
  end
end
