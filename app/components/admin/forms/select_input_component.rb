class Admin::Forms::SelectInputComponent < Admin::Forms::BaseComponent
  private attr_reader :options

  def initialize(form, field, classes:, options:)
    super(form, field, classes:)
    @options = options
  end

  def call
    form.select field, options.keys.map { |w| [w.humanize, w] }, {}, {class: classes}
  end
end
