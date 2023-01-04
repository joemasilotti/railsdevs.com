module Developers
  class PaywalledCardComponent < ApplicationComponent
    with_collection_parameter :developer

    private attr_reader :developer

    def initialize(developer:)
      @developer = developer
    end

    def classes_for_avatar
      [
        (@classes || "h-24 w-24 sm:h-32 sm:w-32 ring-4 ring-white"),
        "object-cover rounded-full",
        "bg-navy": Feature.enabled?(:redesign),
        "bg-gray-300": !Feature.enabled?(:redesign)
      ]
    end

    def avatar_file_name
      developer.avatar_file_name
    end

    def hero
      developer.hero
    end

    def bio
      developer.bio
    end
  end
end
