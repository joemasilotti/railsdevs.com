class ExternalLinkComponent < ApplicationComponent
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
    if @href.start_with?("https://", "http://")
      @href
    else
      "https://#{@href}"
    end
  end
end
