module FormHelper
  def field_classes(form, field, type: :text_field)
    status = (form.object.errors[field].any? ? :error : :clean)
    yass(input: [type => status])
  end
end
