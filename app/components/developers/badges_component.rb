module Developers
  class BadgesComponent < ApplicationComponent
    delegate :featured?, to: :developer
    delegate :recently_active?, to: :developer
    delegate :source_contributor?, to: :developer
    delegate :response_rate, to: :developer

    private attr_reader :developer

    def initialize(developer)
      @developer = developer
    end
  end
end
