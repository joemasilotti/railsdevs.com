module Developers
  module RichText
    def rich_text_bio
      @rich_text_bio ||= markdown.render(bio).strip
    end

    private

    # https://github.com/vmg/redcarpet#darling-i-packed-you-a-couple-renderers-for-lunch
    MARKDOWN_OPTIONS = {
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      highlight: true,
      strikethrough: true,
      superscript: true,
      underline: true
    }.freeze
    RENDER_OPTIONS = {
      filter_html: true,
      hard_wrap: true,
      no_images: true,
      no_links: true,
      no_styles: true
    }.freeze

    def renderer
      @renderer ||= Redcarpet::Render::HTML.new(RENDER_OPTIONS)
    end

    def markdown
      @markdown ||= Redcarpet::Markdown.new(renderer, MARKDOWN_OPTIONS)
    end
  end
end
