module Admin
  class BreadcrumbComponent < ApplicationComponent
    private attr_reader :title, :path

    def initialize(title, path)
      @title = title
      @path = path
    end

    def call
      tag.div class: "flex justify-center mt-2" do
        link_to title, path, class: "text-sm font-medium text-gray-500 hover:text-gray-700"
      end
    end
  end
end
