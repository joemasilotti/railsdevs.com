module Admin
  module Forms
    class TextAreaInputComponent < BaseComponent
      private attr_reader :cols, :rows

      def initialize(form, field, classes:, cols: nil, rows: nil)
        super(form, field, classes:)
        @cols = cols
        @rows = rows
      end

      def call
        form.text_area(field, class: classes, cols:, rows:)
      end
    end
  end
end
