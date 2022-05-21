class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.string :name, null: false
      t.boolean :active, default: false
      t.references :developer

      t.timestamps
    end
  end
end
