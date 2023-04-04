class AddSchedulingLinkToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :scheduling_link, :string
  end
end
