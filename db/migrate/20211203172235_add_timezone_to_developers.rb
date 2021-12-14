class AddTimezoneToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :time_zone, :string
  end
end
