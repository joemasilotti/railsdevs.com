class AboutController < ApplicationController
  def show
    @hero = renderer.render(File.read(file("hero"))).html_safe
    @body = renderer.render(File.read(file("body"))).html_safe
  end

  private

  def renderer
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def file(name)
    Rails.root.join("app/views/about/show.#{name}.md")
  end
end
