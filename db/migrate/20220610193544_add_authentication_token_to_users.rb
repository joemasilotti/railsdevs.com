class AddAuthenticationTokenToUsers < ActiveRecord::Migration[7.0]
  class User < ActiveRecord::Base
    has_secure_token :authentication_token
  end

  def change
    add_column :users, :authentication_token, :string
    User.find_each.map(&:regenerate_authentication_token)
    add_index :users, :authentication_token, unique: true
  end
end
