class ChangeDevelopersAvailableOn < ActiveRecord::Migration[7.0]
  def change
    change_column_null :developers, :available_on, true
  end
end
