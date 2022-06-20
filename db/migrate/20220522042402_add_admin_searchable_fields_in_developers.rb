class AddAdminSearchableFieldsInDevelopers < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE developers
        ADD COLUMN admin_textsearchable_index_col tsvector
          GENERATED ALWAYS AS (to_tsvector('simple', coalesce(name, ''))) STORED;
    SQL

    add_index :developers, :admin_textsearchable_index_col, using: :gin, name: :admin_textsearchable_index
  end

  def down
    remove_index :developers, name: :admin_textsearchable_index
    remove_column :developers, :admin_textsearchable_index_col
  end
end
