class AddAuthenticationTokenToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :authentication_token, :string
    User.find_each(&:save) # Trigger User#ensure_authentication_token.
    change_column_null :users, :authentication_token, false
  end

  def down
    remove_column :users, :authentication_token
  end
end
