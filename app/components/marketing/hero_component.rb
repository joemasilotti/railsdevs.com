class Marketing::HeroComponent < ApplicationComponent
  def initialize(title:, subtitle_1: nil, subtitle_2: nil, dark_bg: false)
    @title = title
    @subtitle_1 = subtitle_1
    @subtitle_2 = subtitle_2
    @dark_bg = dark_bg
  end
end
