class AddDevelopersProfileUpdatedAtAndBumpedAt < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :profile_updated_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
    add_column :developers, :bumped_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }

    Developer.update_all("profile_updated_at=updated_at")
    Developer.update_all("bumped_at=updated_at")
  end
end
