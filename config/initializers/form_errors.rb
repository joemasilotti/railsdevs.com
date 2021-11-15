# Add error span to form fields with errors
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  FieldErrorTagBuilder.new(html_tag, instance).error_field
end
