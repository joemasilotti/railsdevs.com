# Add error span to form fields with errors
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if /<label/.match?(html_tag)
    # Remove text color if it exists so that container color takes precedence
    text_color_regex = %r{text-\w*-\d*[^\s"]}
    text_color_free_html_tag = html_tag.gsub(text_color_regex, "")

    errors = Array(instance.error_message).join(",")
    error_message = %(<span class="mt-2 text-sm font-medium">&nbsp;#{errors}</span>).html_safe
    closing_tag_index = text_color_free_html_tag.index("</label>")
    %(<div class="contents text-red-600">#{text_color_free_html_tag.insert(closing_tag_index, error_message)}</div>).html_safe
  else
    html_tag
  end
end
