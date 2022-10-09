module LinksHelper
  def link_to_active(name, options = {}, html_options = {}, &block)
    html_options[:class] += ' ' + html_options.delete(:active_class) if current_page?(options.to_s)

    link_to(name, options, html_options, &block)
  end

  def normalized_href(href)
    if href.start_with?('https://', 'http://')
      href
    else
      "https://#{href}"
    end
  end
end
