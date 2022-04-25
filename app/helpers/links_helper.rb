module LinksHelper
  def link_to_active(name, options = {}, html_options = {}, &block)
    if current_page?(options.to_s)
      html_options[:class] += " " + html_options.delete(:active_class)
    end

    link_to(name, options, html_options, &block)
  end
end
