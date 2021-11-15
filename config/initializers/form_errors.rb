# Add error span to form fields with errors
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if /<label/.match?(html_tag)
    # Remove text color if it exists so that container color takes precedence
    tag_manipulator = TagColorManipulator.new(html_tag)
    color_free_html_tag = tag_manipulator.remove_text_color

    # Wrap errors in a span tag that we will insert into label tag
    errors = Array(instance.error_message).join(",")
    error_message = %(<span class="mt-2 text-sm font-medium">&nbsp;#{errors}</span>).html_safe

    # Get index of closing label tag for insertion of error message span
    closing_tag_index = color_free_html_tag.index("</label>")
    color_free_html_tag_with_errors = color_free_html_tag.insert(closing_tag_index, error_message)

    # Wrap label in element styled for errors
    %(<div class="contents text-red-600">#{color_free_html_tag_with_errors}</div>).html_safe
  else
    html_tag
  end
end
