class AddSearchScoreToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :search_score, :integer, null: false, default: 0
  end
end
