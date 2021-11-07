# frozen_string_literal: true

class CoverImageComponent < ViewComponent::Base
  def initialize(developer:, data: {}, classes: "")
    @image = developer.cover_image.attached? ?
      developer.cover_image :
      "default_splash.jpg"
    @data = data
    @classes = classes
  end
end
