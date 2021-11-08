class DeprecateDevelopersEmail < ActiveRecord::Migration[7.0]
  def change
    # Non-null for now, but will be removed later.
    change_column_null :developers, :email, true
  end
end
