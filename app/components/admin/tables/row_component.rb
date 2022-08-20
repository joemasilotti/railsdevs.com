module Admin
  module Tables
    class RowComponent < ApplicationComponent
      renders_many :cells, CellComponent
    end
  end
end
