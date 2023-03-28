class MigrateUrlAttributes < ActiveRecord::Migration[7.0]
  class Developer < ActiveRecord::Base
  end

  class Business < ActiveRecord::Base
  end

  def up
    # Reprocess URL attributes without touching updated_at.
    process_developers
    process_businesses
  end

  def down
    # Nothing needs to be done.
  end

  private

  def process_developers
    developers_to_process = Developer.where.not(
      website: blank_query,
      mastodon: blank_query,
      scheduling_link: blank_query,
      github: blank_query,
      twitter: blank_query,
      linkedin: blank_query,
      stack_overflow: blank_query
    )

    developers_to_process.find_each do |developer|
      developer.update_columns(
        website: normalize_url(developer.website),
        mastodon: normalize_url(developer.mastodon),
        scheduling_link: normalize_url(developer.scheduling_link),

        github: normalize_url(developer.github, prefix: "github.com/"),
        twitter: normalize_url(developer.twitter, prefix: "twitter.com/"),
        linkedin: normalize_url(developer.linkedin, prefix: "linkedin.com/in/"),

        stack_overflow: normalize_url(developer.stack_overflow, prefix: "stackoverflow.com/users/") do |value|
          normalized_value = value[%r{^(\d+)/}, 1] # "12345/user-name" => "12345"
          normalized_value.presence || value
        end
      )
    end
  end

  def process_businesses
    Business.where.not(website: blank_query).find_each do |business|
      business.update_columns(website: normalize_url(business.website))
    end
  end

  def blank_query
    @blank_query ||= [nil, ""]
  end

  def normalize_url(value, prefix: nil)
    return value if value.blank?

    normalized_value = value.to_s.strip
    normalized_value.gsub!(%r{^https?://}, "")
    normalized_value.gsub!(%r{^(www\.)?#{prefix}}, "") if prefix.present?
    normalized_value = yield(normalized_value) if block_given?
    normalized_value
  end
end
