class AddFeaturedAtToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :featured_at, :datetime
  end
end
