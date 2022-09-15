module Developers
  module RichText
    def rich_text_bio
      @rich_text_bio ||= markdown.render(bio).strip
    end

    private

    MARKDOWN_OPTIONS = {
      disable_indented_code_blocks: true, # Disabled convertion of four spaces to code block
      fenced_code_blocks: true, # Allows multi-line codeblock (with 3 ` or 3 ~)
      highlight: true, # Allows highlighting
      strikethrough: true, # Allows strikethrough
      superscript: true, # Disables convertion of text with four spaces at the front of each line to code blocks.
      underline: true # Allows underline
    }.freeze
    RENDER_OPTIONS = {
      filter_html: true, # Disallows manually written HTML tags
      hard_wrap: true, # Adds newline everytime "Return" is hit
      no_images: true, # Disables images
      no_links: true, # Disables links
      no_styles: true # Disables custom styling
    }.freeze

    def renderer
      @renderer ||= DeveloperBioRender.new(RENDER_OPTIONS)
    end

    def markdown
      @markdown ||= Redcarpet::Markdown.new(renderer, MARKDOWN_OPTIONS)
    end
  end
end
