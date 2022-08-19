class Admin::BasicLinkComponent < ApplicationComponent
  private attr_reader :title, :path

  def initialize(title, path)
    @title = title
    @path = path
  end

  def call
    link_to title, path, class: "hover:underline"
  end
end
