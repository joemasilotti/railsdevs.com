module Admin
  class ContentComponent < ApplicationComponent
    def call
      tag.div class: "w-full max-w-5xl mx-auto mt-8" do
        tag.div content, class: "px-4 sm:px-6 lg:px-8"
      end
    end
  end
end
