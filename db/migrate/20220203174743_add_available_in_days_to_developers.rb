class AddAvailableInDaysToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :available_in_days, :integer
  end
end
