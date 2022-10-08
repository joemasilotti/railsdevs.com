module Admin
  class DescriptionComponent < ApplicationComponent
    attr_reader :term, :definition

    def initialize(term, definition = nil, wide: false)
      @term = term
      @definition = definition
      @wide = wide
    end

    def wide?
      !!@wide
    end
  end
end
