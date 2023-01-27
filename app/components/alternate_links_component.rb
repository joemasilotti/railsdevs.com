class AlternateLinksComponent < ApplicationComponent
  def locales
    I18n.available_locales
  end

  def href_for(locale)
    url_for(locale: helpers.resolve_locale(locale), only_path: false)
  end

  def hreflang_for(locale)
    (locale == I18n.locale) ? "x-default" : locale
  end
end
