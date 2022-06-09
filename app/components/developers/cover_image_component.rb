module Developers
  class CoverImageComponent < ViewComponent::Base
    DEFAULT_COVER = "default_splash.jpg"

    attr_reader :image, :data, :classes

    def initialize(developer:, data: {}, classes: "")
      @image = developer.cover_image.attached? ? developer.cover_image : DEFAULT_COVER
      @data = data
      @classes = classes
    end
  end
end
