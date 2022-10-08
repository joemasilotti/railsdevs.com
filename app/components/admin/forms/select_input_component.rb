module Admin
  module Forms
    class SelectInputComponent < BaseComponent
      private attr_reader :options, :include_blank

      def initialize(form, field, classes:, options:, include_blank: false)
        super(form, field, classes:)
        @options = options
        @include_blank = include_blank
      end

      def call
        form.select field, options.keys.map { |w| [w.humanize, w] }, {include_blank: include_blank}, {class: classes}
      end
    end
  end
end
