# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://railsdevs.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add developers_path, changefreq: 'always', priority: 1, lastmod: Developer.order(id: :desc).first.try(:updated_at)
  add about_path, changefreq: 'weekly', priority: 0.9

  Developer.most_recently_added.find_each do |developer|
    add developer_path(id: developer.id), changefreq: 'always', priority: 0.8, lastmod: developer.updated_at
  end

  add new_user_session_path, changefreq: 'weekly', priority: 0.7
  add new_user_registration_path, changefreq: 'weekly', priority: 0.7
  add new_user_password_path, changefreq: 'monthly', priority: 0.7
  add new_user_confirmation_path, changefreq: 'monthly', priority: 0.7

  add new_role_path, changefreq: 'weekly', priority: 0.6
  add new_developer_path, changefreq: 'weekly', priority: 0.6
  add new_business_path, changefreq: 'weekly', priority: 0.6
  add pricing_path, changefreq: 'weekly', priority: 0.5
end
