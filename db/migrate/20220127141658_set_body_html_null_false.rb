class SetBodyHtmlNullFalse < ActiveRecord::Migration[7.0]
  def change
    execute "UPDATE messages SET body_html = '' WHERE body_html IS NULL"

    change_column_null :messages, :body_html, false
  end
end
