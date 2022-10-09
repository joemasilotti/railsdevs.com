class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.attached?

    content_types = Array(options[:in])
    record.errors.add(attribute, :content_type_invalid) if content_types.exclude?(value.content_type)
  end
end
