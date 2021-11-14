class OpenGraphTagsComponent < ViewComponent::Base
  def initialize(title: nil, description: nil)
    @title = title
    @description = description
  end

  def title
    @title || "railsdevs"
  end

  def description
    @description || "Find Ruby on Rails developers looking for freelance, contract, and full-time work."
  end

  def url
    root_url
  end

  def image
    nil
  end

  def twitter
    "@joemasilotti"
  end
end
