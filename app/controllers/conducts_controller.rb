class ConductsController < ApplicationController
  def show
    @body = renderer.render(File.read(file)).html_safe
  end

  private

  def renderer
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def file
    Rails.root.join("CODE_OF_CONDUCT.md")
  end
end
