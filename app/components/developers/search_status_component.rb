module Developers
  class SearchStatusComponent < ApplicationComponent
    attr_reader :developer

    def initialize(developer)
      @developer = developer
    end

    def render?
      developer.search_status.present?
    end

    def icon_tag
      inline_svg_tag "icons/solid/#{icon}.svg", class: icon_classes.join(" ")
    end

    def text_classes
      if developer.actively_looking?
        "text-green-700"
      else
        "text-gray-900"
      end
    end

    def humanize(enum_value)
      # i18n-tasks-use t('developers.search_status.actively_looking')
      # i18n-tasks-use t('developers.search_status.not_interested')
      # i18n-tasks-use t('developers.search_status.open')
      Developer.human_attribute_name "search_status.#{enum_value}"
    end

    private

    def icon
      if developer.actively_looking? || developer.open?
        "search_circle"
      else
        "x_circle"
      end
    end

    def icon_classes
      %w[h-5 w-5].tap do |classes|
        classes << if developer.actively_looking?
          "text-green-500"
        else
          "text-gray-400"
        end
      end
    end
  end
end
