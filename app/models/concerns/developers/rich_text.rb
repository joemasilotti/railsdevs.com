module Developers
  module RichText
    def rich_text_bio
      @rich_text_bio ||= markdown.render(bio).strip
    end

    private

    MARKDOWN_OPTIONS = {
      disable_indented_code_blocks: true,
      fenced_code_blocks: true, # Allows multi-line codeblock
      highlight: true, # Allows highlighting
      strikethrough: true, # Allows strikethrough
      superscript: true, # Disables convertion of text with four spaces at the front of each line to code blocks.
      underline: true, # Allows underline
    }
    RENDER_OPTIONS = {
      filter_html: true, # Disallows HTML tags
      hard_wrap: true, # Adds newline everytime "Enter" is hit
      no_images: true, # Disables images
      no_links: true, # Disables links
      no_styles: true, # Disables custom styling
    }

    def renderer
      @renderer ||= Redcarpet::Render::HTML.new(RENDER_OPTIONS)
    end

    def markdown
      @markdown ||= Redcarpet::Markdown.new(renderer, MARKDOWN_OPTIONS)
    end
  end
end
