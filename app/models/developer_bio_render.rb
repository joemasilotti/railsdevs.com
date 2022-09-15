class DeveloperBioRender < Redcarpet::Render::HTML
  # Any MD links will be rendered as an empty string
  def link(link, title, content)
    ""
  end

  # Any MD images will be rendered as empty string
  def image(link, title, alt_text)
    ""
  end
end
