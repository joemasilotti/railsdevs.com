module Developers
  class BadgesComponent < ApplicationComponent
    delegate :featured?,
      :high_response_rate?,
      :recently_updated?,
      :recently_added?,
      :source_contributor?,
      :response_rate,
      to: :developer

    private attr_reader :developer

    def initialize(developer)
      @developer = developer
    end
  end
end
