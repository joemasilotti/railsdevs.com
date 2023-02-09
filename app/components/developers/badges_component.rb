module Developers
  class BadgesComponent < ApplicationComponent
    delegate :featured?, to: :developer
    delegate :recently_active?, to: :badge
    delegate :source_contributor?, to: :badge

    private attr_reader :developer, :badge

    def initialize(developer)
      @developer = developer
      @badge = developer.badge
    end
  end
end
