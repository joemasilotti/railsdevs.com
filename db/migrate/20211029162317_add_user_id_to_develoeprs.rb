class AddUserIdToDeveloeprs < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :user_id, :integer
  end
end
