class OpenGraphTagsComponent < ApplicationComponent
  def initialize(title: nil, description: nil, image: nil)
    @title = title
    @description = description
    @image = image
  end

  def title
    @title || "railsdevs"
  end

  def description
    @description || t("open_graph_tags_component.default_description")
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
