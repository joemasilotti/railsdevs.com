module Developers
  class BadgeComponent < ApplicationComponent
    private attr_reader :title, :color

    def initialize(title, color:)
      @title = title
      @color = color
    end

    def call
      tag.span title, class: "inline-flex items-center rounded-md px-2.5 py-0.5 text-sm font-medium bg-#{color}-100 text-#{color}-800"
    end
  end
end
