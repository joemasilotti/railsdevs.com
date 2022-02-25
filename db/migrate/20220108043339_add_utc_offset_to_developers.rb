class AddUTCOffsetToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :utc_offset, :int
  end
end
