class ExternalLinkComponent < ViewComponent::Base
  def initialize(title, href, options = {})
    @title = title
    @href = href
    @options = options
  end

  def render?
    @href.present?
  end

  def href
    if @href.start_with?("https://", "http://")
      @href
    else
      "https://#{@href}"
    end
  end

  def options
    @options.merge(target: "_blank")
  end
end
