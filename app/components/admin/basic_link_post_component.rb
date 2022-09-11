module Admin
  class BasicLinkPostComponent < ApplicationComponent
    private attr_reader :title, :path, :name, :val

    def initialize(title, path, name:, val:)
      @title = title
      @path = path
      @val = val
      @name = name
    end

    def call
      form_with url: path do |form|
        form.hidden_field(name, value: val) + form.submit(title, class: "hover:underline")
      end
    end
  end
end
