class SocialLinkComponent < ApplicationComponent
  include LinksHelper

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
    case network
    when :github
      "https://github.com/#{handle}"
    when :gitlab
      "https://gitlab.com/#{handle}"
    when :twitter
      "https://twitter.com/#{handle}"
    when :mastodon
      normalized_href(handle)
    when :linkedin
      "https://www.linkedin.com/in/#{handle}"
    when :stack_overflow
      "https://stackoverflow.com/users/#{handle}"
    end
  end

  def icon
    "icons/brands/#{network}.svg"
  end
end
