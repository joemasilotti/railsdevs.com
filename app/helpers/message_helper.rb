module MessageHelper
  def smart_format(string, **options)
    link_filter = AutoHtml::Link.new
    with_links = link_filter.call(string)

    simple_format(with_links, options)
  end
end
