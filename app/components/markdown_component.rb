class MarkdownComponent < ApplicationComponent
  private attr_reader :path, :localize

  def initialize(path, localize: true)
    @path = path
    @localize = localize
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

  def self.code_of_coduct
    new("CODE_OF_CONDUCT.md", localize: false)
  end

  def rendered_markdown
    MarkdownRenderer.new(path, localize:).render
  end
end
