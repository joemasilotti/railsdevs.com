class AddPublicProfileKeyToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :public_profile_key, :string
    add_index :developers, :public_profile_key, unique: true
  end
end
