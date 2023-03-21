class AddProductAnnouncementNotficationToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :product_announcement_notifications, :boolean, default: true
  end
end
