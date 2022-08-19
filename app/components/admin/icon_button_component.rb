module Admin
  class IconButtonComponent < ApplicationComponent
    attr_reader :title, :path, :icon

    def initialize(title, path, icon:)
      @title = title
      @path = path
      @icon = icon
    end
  end
end
