class AddSourceContributorToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :source_contributor, :boolean, null: false, default: false
  end
end
