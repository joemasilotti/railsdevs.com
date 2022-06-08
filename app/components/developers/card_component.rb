module Developers
  class CardComponent < ApplicationComponent
    with_collection_parameter :developer

    attr_reader :developer

    def initialize(developer:, featured: false)
      @developer = developer
      @featured = featured
    end

    def hero
      @developer.hero
    end

    def bio
      @developer.bio
    end

    def featured?
      !!@featured
    end
  end
end
