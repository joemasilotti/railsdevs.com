class ButtonLinkComponent < ViewComponent::Base
  def initialize(href, icon: nil)
    @href = href
    @icon = icon
  end

  def icon_path
    return unless @icon.present?

    "icons/solid/#{@icon}.svg"
  end
end
