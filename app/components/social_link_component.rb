class SocialLinkComponent < ApplicationComponent
  attr_reader :network

  def initialize(handle, network)
    @handle = handle
    @network = network
  end

  def render?
    handle.present?
  end

  def handle
    sanitize(@handle)
  end

  def url
    prefix = case network
    when :github
      "https://github.com/"
    when :twitter
      "https://twitter.com/"
    when :linkedin
      "https://www.linkedin.com/in/"
    end
    "#{prefix}#{handle.delete_prefix(prefix)}"
  end

  def icon
    "icons/brands/#{network}.svg"
  end
end
