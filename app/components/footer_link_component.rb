class FooterLinkComponent < ApplicationComponent
  def initialize(link:, external: false, **options)
    @link = link
    @external = external
    @options = html_options
  end

  def html_options
    standard_options = {
      class: [
        "text-base",
        "text-gray-500 hover:text-gray-900": !Feature.enabled?(:redesign),
        "text-typography hover:text-navy-mid": Feature.enabled?(:redesign)
      ]
    }
    standard_options.merge(**@options) unless @options.nil?

    @external ? standard_options.merge({target: "_blank"}) : standard_options
  end
end
