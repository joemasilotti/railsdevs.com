module Developers
  class CoverImageComponent < ViewComponent::Base
    DEFAULT_COVER = "default_splash.jpg"

    attr_reader :developer, :data, :classes

    def initialize(developer:, data: {}, classes: "")
      @developer = developer
      @data = data
      @classes = classes
    end

    def cover_image_url
      return image_path(DEFAULT_COVER) unless developer.cover_image.attached?
      url_for developer.cover_image
    end
  end
end
