module Admin
  module Forms
    class BaseComponent < ApplicationComponent
      attr_reader :form, :field, :classes

      def initialize(form, field, classes:)
        @form = form
        @field = field
        @classes = classes
      end
    end
  end
end
