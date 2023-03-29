desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task url_attributes: :environment do
    blank_query = [nil, ""]

    developer_tmp_record = Developer.new
    developer_attrs = %i[website mastodon scheduling_link github twitter linkedin stack_overflow]
    Developer.where.not(developer_attrs.map { |a| [a, blank_query] }.to_h).find_each do |developer|
      attrs_to_update = {}
      developer_attrs.each do |attr|
        developer_tmp_record.public_send("#{attr}=", developer.public_send(attr))
        attrs_to_update[attr] = developer_tmp_record.public_send(attr)
      end
      developer.update_columns(attrs_to_update)
    end

    business_tmp_record = Business.new
    Business.where.not(website: blank_query).find_each do |business|
      business_tmp_record.website = business.website
      business.update_columns(website: business_tmp_record.website)
    end
  end
end
