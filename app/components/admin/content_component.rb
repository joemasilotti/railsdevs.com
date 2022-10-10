module Admin
  class ContentComponent < ApplicationComponent
    private attr_reader :width

    def initialize(width: "max-w-5xl")
      @width = width
    end

    def call
      tag.div class: class_names("w-full mx-auto mt-8", width) do
        tag.div content, class: "px-4 sm:px-6 lg:px-8"
      end
    end
  end
end
