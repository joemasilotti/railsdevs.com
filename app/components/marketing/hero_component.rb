class Marketing::HeroComponent < ApplicationComponent
  def initialize(title:, subtitle_1: nil, subtitle_2: nil)
    @title = title
    @subtitle_1 = subtitle_1
    @subtitle_2 = subtitle_2
  end
end
