module Developers
  class CountComponent < ApplicationComponent
    attr_reader :count, :total

    def initialize(count:, total:)
      @count = count
      @total = total
    end
  end
end
