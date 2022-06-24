module Developers
  class BannerComponent < ApplicationComponent
    private attr_reader :banners, :selected_banner

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
    end

    private
  end
end
