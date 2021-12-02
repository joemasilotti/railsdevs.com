# app/errors/application_error.rb
class ApplicationError < StandardError
  # Look up translations via "errors.module_name.class_name".
  def message
    I18n.t("errors.#{self.class.name.underscore.tr("/", ".")}")
  end
end
