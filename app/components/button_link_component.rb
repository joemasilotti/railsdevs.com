class ButtonLinkComponent < ViewComponent::Base
  def initialize(href, icon: nil, data: {})
    @href = href
    @icon = icon
    @data = data
  end

  def icon_path
    return unless @icon.present?

    "icons/solid/#{@icon}.svg"
  end
end
