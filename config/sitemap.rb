SitemapGenerator::Sitemap.default_host = "https://railsdevs.com"

SitemapGenerator::Sitemap.create do
  add developers_path, changefreq: "always", priority: 1, lastmod: Developer.maximum(:updated_at)
  add about_path, changefreq: "weekly", priority: 0.9

  Developer.most_recently_added.find_each do |developer|
    add developer_path(id: developer.id), changefreq: "always", priority: 0.8, lastmod: developer.updated_at
  end

  add new_user_session_path, changefreq: "weekly", priority: 0.7
  add new_user_registration_path, changefreq: "weekly", priority: 0.7
  add new_user_password_path, changefreq: "monthly", priority: 0.7
  add new_user_confirmation_path, changefreq: "monthly", priority: 0.7

  add new_role_path, changefreq: "weekly", priority: 0.6
  add new_developer_path, changefreq: "weekly", priority: 0.6
  add new_business_path, changefreq: "weekly", priority: 0.6
  add pricing_path, changefreq: "weekly", priority: 0.5
end
