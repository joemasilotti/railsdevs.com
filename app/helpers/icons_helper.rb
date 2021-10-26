module IconsHelper
  def icon(name, options = {})
    asset = Rails.application.assets.find_asset("icons/#{name}")

    if asset
      file = asset.source.force_encoding("UTF-8")
      doc = Nokogiri::HTML::DocumentFragment.parse(file)
      svg = doc.at_css("svg")
      svg["class"] = options[:class] if options[:class].present?
    else
      doc = "<!-- SVG #{name} not found -->"
    end

    raw(doc)
  end
end
