class AboutController < ApplicationController
  def show
    @hero = MarkdownRenderer.new("about/hero").render
    @body = MarkdownRenderer.new("about/body").render
  end
end
