class AddInvisibleFlagToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :invisible, :boolean, null: false, default: false
  end
end
