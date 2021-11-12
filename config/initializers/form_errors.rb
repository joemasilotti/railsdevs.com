# Add error span to form fields with errors
Rails.application.config.action_view.field_error_proc = proc do |html_tag, instance| 
  if /<label/.match?(html_tag)
    errors = Array(instance.error_message).join(",")
    error_message = %(<span class="mt-2 text-sm font-medium text-red-600">&nbsp;#{errors}</span>).html_safe
    closing_tag_index = html_tag.index("</label>")
    html_tag.insert(closing_tag_index, error_message)
  else
    html_tag
  end
end
