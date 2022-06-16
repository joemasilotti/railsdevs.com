module NavBar
  class GuestComponent < ApplicationComponent
    attr_reader :links

    def initialize(links:)
      @links = links
    end
  end
end
