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
    filename = "app/views/about/#{I18n.default_locale}/show.#{name}.md"
    filename = "app/views/about/#{I18n.locale}/show.#{name}.md" if File.exist?("app/views/about/#{I18n.locale}/show.#{name}.md")
    Rails.root.join(filename)
  end
end
