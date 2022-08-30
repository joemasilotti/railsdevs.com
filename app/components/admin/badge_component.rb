module Admin
  class BadgeComponent < ApplicationComponent
    private attr_reader :title

    def initialize(title)
      @title = title
    end

    def call
      tag.span title, class: "inline-flex items-center rounded-full bg-blue-100 px-3 py-0.5 text-sm font-medium text-blue-800"
    end
  end
end
