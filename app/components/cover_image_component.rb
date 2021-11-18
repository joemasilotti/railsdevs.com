class CoverImageComponent < ViewComponent::Base
  DEFAULT_COVER = "default_splash.jpg"

  def initialize(developer:, data: {}, classes: "")
    @image = developer.cover_image.attached? ? developer.cover_image : DEFAULT_COVER
    @data = data
    @classes = classes
  end
end
