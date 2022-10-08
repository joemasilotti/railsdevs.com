module Admin
  class LinkComponent < ApplicationComponent
    private attr_reader :title, :path

    def initialize(title, path)
      @title = title
      @path = path
    end

    def call
      link_to title, path, class: "rounded-md bg-white font-medium text-blue-600 hover:text-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
    end
  end
end
