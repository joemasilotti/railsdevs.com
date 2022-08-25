module Admin
  class BasicLinkComponent < ApplicationComponent
    private attr_reader :title, :path, :external, :data

    def initialize(title, path, external: false, data: {})
      @title = title
      @path = path
      @external = external
      @data = data
    end

    def call
      link_to title, path, class: "hover:underline", target:, data:
    end

    private

    def target
      "_blank" if external
    end
  end
end
