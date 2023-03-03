class AddResponseRateToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :response_rate, :integer, null: false, default: 0
  end
end
