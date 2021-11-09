class OpenGraphTagsComponent < ViewComponent::Base
  def title
    "railsdevs.io"
  end

  def description
    "Find Ruby on Rails developers looking for freelance and full-time work."
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
