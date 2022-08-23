module Admin
  module Forms
    class Forms::FieldComponent < ApplicationComponent
      renders_one :input, types: {
        text: ->(**args) { TextInputComponent.new(form, field, classes:, **args) },
        text_area: ->(**args) { TextAreaInputComponent.new(form, field, classes:, **args) },
        select: ->(**args) { SelectInputComponent.new(form, field, classes:, **args) },
        currency: ->(**args) { CurrencyInputComponent.new(form, field, classes:, **args) }
      }

      attr_reader :form, :field, :label, :help

      def initialize(form, field, label: nil, help: nil)
        @form = form
        @field = field
        @label = label
        @help = help
      end

      def classes
        class_names("block w-full sm:text-sm rounded-md", {
          "focus:ring-red-500 focus:border-red-500 border-red-300": errors?,
          "focus:ring-gray-500 focus:border-gray-500 border-gray-300": !errors?
        })
      end

      private

      def errors?
        form.object.errors[field].any?
      end
    end
  end
end
