class AddDemoToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :demo, :boolean, null: false, default: false
  end
end
