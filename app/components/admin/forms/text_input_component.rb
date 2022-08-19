class Admin::Forms::TextInputComponent < Admin::Forms::BaseComponent
  def initialize(form, field, classes:, type: :text)
    super(form, field, classes:)
    @type = type
  end

  def call
    form.send(method, field, class: classes)
  end

  private

  def method
    "#{@type}_field"
  end
end
