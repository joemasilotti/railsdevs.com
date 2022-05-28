class CreatePromptResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :prompt_responses do |t|
      t.string :content
      t.references :developer, foreign_key: true
      t.references :prompt, foreign_key: true

      t.timestamps
    end
  end
end
