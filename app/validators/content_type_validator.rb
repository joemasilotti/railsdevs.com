class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.attached?

    content_types = Array(options[:in])
    if content_types.exclude?(value.content_type)
      record.errors.add(attribute, :content_type_invalid)
    end
  end
end
