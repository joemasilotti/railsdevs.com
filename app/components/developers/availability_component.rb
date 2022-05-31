module Developers
  class AvailabilityComponent < ApplicationComponent
    attr_reader :developer

    def initialize(developer:, show_unavailable_icon: false)
      @developer = developer
      @show_unavailable_icon = show_unavailable_icon
    end

    def availability_icon
      return unless available? || show_unavailable_icon?

      icon = available? ? :check_circle : :x_circle

      css = %w[h-5 w-5]
      css << (available? ? "text-green-500" : "text-gray-400")

      inline_svg_tag "icons/solid/#{icon}.svg", class: css.join(" ")
    end

    def date
      developer.available_on&.to_formatted_s(:db)
    end

    def date_in_words
      return unless developer.available_in_future?

      time_ago_in_words(developer.available_on)
    end

    private

    def show_unavailable_icon?
      !!@show_unavailable_icon
    end

    def available?
      developer.available_now?
    end
  end
end
