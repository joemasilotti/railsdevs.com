class ExternalLinkComponent < ApplicationComponent
  include LinksHelper

  def initialize(href)
    @href = href
  end

  def render?
    @href.present?
  end

  def title
    @href
  end

  def href
    normalized_href(@href)
  end
end
