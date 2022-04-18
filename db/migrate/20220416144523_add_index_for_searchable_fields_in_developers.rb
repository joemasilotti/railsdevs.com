class AddIndexForSearchableFieldsInDevelopers < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE developers
        ADD COLUMN textsearchable_index_col tsvector
          GENERATED ALWAYS AS (to_tsvector('simple', coalesce(hero, '') || ' ' || coalesce(bio, ''))) STORED;
    SQL

    add_index :developers, :textsearchable_index_col, using: :gin, name: :textsearchable_index
  end

  def down
    remove_index :developers, name: :textsearchable_index
    remove_column :developers, :textsearchable_index_col
  end
end
