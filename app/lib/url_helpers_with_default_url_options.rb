module UrlHelpersWithDefaultUrlOptions
  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.routes.default_url_options
  end
end
