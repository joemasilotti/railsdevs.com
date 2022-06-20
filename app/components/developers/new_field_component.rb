module Developers
  class NewFieldComponent < ApplicationComponent
    def initialize(developer, field, size: :large)
      @developer = developer
      @field = field
      @size = size
    end

    def render?
      @developer.persisted? && field_missing?
    end

    def large?
      @size == :large
    end

    private

    def field_missing?
      field = @developer.send(@field)
      if field.respond_to?(:missing_fields?)
        field.missing_fields?
      else
        field.blank?
      end
    end
  end
end
