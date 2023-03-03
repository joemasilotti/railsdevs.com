class AddMastodonToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :mastodon, :string
  end
end
