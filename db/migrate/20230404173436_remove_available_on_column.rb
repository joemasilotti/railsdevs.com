class RemoveAvailableOnColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :developers, :available_on, :date, null: true
  end
end
