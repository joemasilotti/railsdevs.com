class AddBodyHtmlToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :body_html, :text
  end
end
