class AddWebsiteUrlAndContactRoleToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :website_url, :string, null: true
    add_column :businesses, :contact_role, :string, null: true
    rename_column :businesses, :name, :contact_name
  end
end
