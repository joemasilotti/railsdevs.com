class NotUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil? || value.match(/(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#()?&\/=]*)/).nil?
      record.errors.add(attribute, "profile link must be only the username and not the full website address")
    end
  end
end
