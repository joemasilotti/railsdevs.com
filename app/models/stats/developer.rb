module Stats
  class Developer
    private attr_reader :developers

    def initialize(developers)
      @developers = developers
    end

    def count
      @count = developers.count
    end

    def looking_and_open
      @looking_and_open = developers.where(search_status: [:open, :actively_looking]).count
    end
  end
end
