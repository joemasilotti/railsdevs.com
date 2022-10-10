module Admin
  class BasicLinkPostComponent < ApplicationComponent
    private attr_reader :title, :path, :name, :value

    def initialize(title, path, name:, value:)
      @title = title
      @path = path
      @value = value
      @name = name
    end

    def call
      button_to(title, path, {class: "hover:underline", params: {name => value}})
    end
  end
end
