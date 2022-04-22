class MarkdownRenderer
  private attr_reader :view_directory

  def initialize(view_directory)
    @view_directory = view_directory
  end

  def render
    renderer.render(File.read(file))
  end

  private

  def renderer
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def file
    translated_file = file_path(I18n.locale)
    if File.exist?(translated_file)
      translated_file
    else
      file_path(I18n.default_locale)
    end
  end

  def file_path(locale)
    Rails.root.join("app/views", view_directory, "#{locale}.md")
  end
end
