module Developers
  class CardComponent < ApplicationComponent
    with_collection_parameter :developer

    delegate :featured?, to: :developer

    private attr_reader :developer, :highlight_featured

    def initialize(developer:, highlight_featured: false)
      @developer = developer
      @highlight_featured = highlight_featured
    end

    delegate :hero, to: :developer

    delegate :bio, to: :developer

    def highlight?
      !!highlight_featured && featured?
    end
  end
end
