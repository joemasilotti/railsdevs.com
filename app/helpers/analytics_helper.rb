module AnalyticsHelper
  def analytics_tag
    if Rails.env.production?
      javascript_include_tag "https://cdn.usefathom.com/script.js", defer: true, data: {site: "CACNFAAN"}
    end
  end
end
