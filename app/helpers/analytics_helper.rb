module AnalyticsHelper
  def analytics_tag
    site_id = Rails.configuration.fathom
    javascript_include_tag "https://cdn.usefathom.com/script.js", defer: true, data: {site: site_id}
  end
end
