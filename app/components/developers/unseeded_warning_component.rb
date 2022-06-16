module Developers
  class UnseededWarningComponent < ApplicationComponent
    def initialize(seedable: false)
      @seedable = seedable
    end

    def render?
      @seedable && Developer.none?
    end
  end
end
