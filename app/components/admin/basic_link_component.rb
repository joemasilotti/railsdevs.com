class Admin::BasicLinkComponent < ApplicationComponent
  private attr_reader :title, :path, :external

  def initialize(title, path, external: false)
    @title = title
    @path = path
    @external = external
  end

  def call
    link_to title, path, class: "hover:underline", target:
  end

  private

  def target
    external ? "_blank" : "_self"
  end
end
