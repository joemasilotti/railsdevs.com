module MessageHelper
  def smart_format(string, **options)
    with_links = Rinku.auto_link(string)

    simple_format(with_links, options)
  end
end
