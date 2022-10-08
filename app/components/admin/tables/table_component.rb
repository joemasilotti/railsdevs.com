module Admin
  module Tables
    class TableComponent < ApplicationComponent
      renders_many :headers, HeaderComponent
      renders_many :rows, RowComponent
    end
  end
end
