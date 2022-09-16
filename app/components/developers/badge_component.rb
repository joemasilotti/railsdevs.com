module Developers
  class BadgeComponent < ApplicationComponent
    private attr_reader :title, :classes

    def initialize(title, classes)
      @title = title
      @classes = classes
    end

    def call
      tag.span title, class: classes.to_s
    end
  end
end
