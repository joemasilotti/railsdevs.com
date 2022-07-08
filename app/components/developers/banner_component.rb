module Developers
  class BannerComponent < ApplicationComponent
    attr_reader :selected_banner
    private attr_reader :banners

    def initialize(banners)
      @banners = banners
    end

    def render?
      banners.each do |banner|
        if !!banner.render?
          @selected_banner = banner
          return true
        end
      end
      false
    end
  end
end
