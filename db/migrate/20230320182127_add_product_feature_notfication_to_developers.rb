class AddProductFeatureNotficationToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :product_feature_notifications, :boolean, default: true
  end
end
