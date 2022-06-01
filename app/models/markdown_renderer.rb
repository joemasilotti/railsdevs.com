class MarkdownRenderer
  private attr_reader :view_directory, :absolute_path

  def initialize(view_directory_or_absolute_path, localize: true)
    if localize
      @view_directory = view_directory_or_absolute_path
    else
      @absolute_path = view_directory_or_absolute_path
    end
  end

  def render
    renderer.render(File.read(file))
  end

  private

  def renderer
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def file
    if view_directory.present?
      localized_file
    elsif absolute_path.present?
      Rails.root.join(absolute_path)
    end
  end

  def localized_file
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
