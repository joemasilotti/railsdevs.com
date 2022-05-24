class MarkdownComponent < ApplicationComponent
  private attr_reader :path

  def initialize(path)
    @path = path
  end

  def self.messaging_tips
    new("cold_messages/tips")
  end

  def self.about_hero
    new("about/hero")
  end

  def self.about_body
    new("about/body")
  end

  def rendered_markdown
    MarkdownRenderer.new(path).render
  end
end
