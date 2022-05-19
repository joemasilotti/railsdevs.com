module Stats
  class Business
    private attr_reader :businesses

    def initialize(businesses)
      @businesses = businesses
    end

    def count
      @count = businesses.count
    end
  end
end
