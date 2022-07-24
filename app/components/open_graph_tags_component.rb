class OpenGraphTagsComponent < ApplicationComponent
  attr_reader :turbo_native_title

  def initialize(title: nil, turbo_native_title: nil, description: nil, image: nil)
    @title = title
    @turbo_native_title = turbo_native_title
    @description = description
    @image = image
  end

  def title
    if turbo_native_title.present? && helpers.turbo_native_app?
      turbo_native_title
    elsif @title.present? && helpers.turbo_native_app?
      @title
    elsif @title.present?
      "#{@title} · railsdevs"
    else
      "railsdevs"
    end
  end

  def description
    @description || t("home.show.title_og")
  end

  def url
    root_url
  end

  def image
    @image || helpers.image_url("opengraph/default.png")
  end

  def twitter_card
    "summary_large_image"
  end

  def twitter
    "@joemasilotti"
  end
end
