class SetBodyHtmlNullFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_null :messages, :body_html, false
  end
end
