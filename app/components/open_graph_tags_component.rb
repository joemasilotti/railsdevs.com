class OpenGraphTagsComponent < ApplicationComponent
  def initialize(title: nil, description: nil, image: nil)
    @title = title
    @description = description
    @image = image
  end

  def title
    if @title.present?
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
    @image || helpers.image_url("logo.png")
  end

  def twitter
    "@joemasilotti"
  end
end
