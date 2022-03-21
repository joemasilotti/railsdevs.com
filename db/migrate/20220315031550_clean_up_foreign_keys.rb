class CleanUpForeignKeys < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        change_column :developers, :user_id, :bigint
      end

      dir.down do
        change_column :developers, :user_id, :integer
      end
    end

    add_index :developers, :user_id
  end
end
