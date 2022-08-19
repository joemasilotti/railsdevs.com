module Admin
  class HeadingComponent < ApplicationComponent
    private attr_reader :title

    def initialize(title = nil)
      @title = title
    end

    def call
      tag.div class: "flex items-center justify-center" do
        tag.h1 title || content, class: "mt-6 text-center text-3xl font-extrabold"
      end
    end
  end
end
