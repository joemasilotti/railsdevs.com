class MaxFileSizeValidator < ActiveModel::EachValidator
  include ActionView::Helpers::NumberHelper

  def validate_each(record, attribute, value)
    return unless value.attached?

    max_file_size = options[:with]
    if record.send(attribute).blob.byte_size > max_file_size
      size = number_to_human_size(max_file_size)
      record.errors.add(attribute, :max_file_size_invalid, size:)
    end
  end
end
