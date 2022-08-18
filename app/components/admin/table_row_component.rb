class Admin::TableRowComponent < ApplicationComponent
  renders_many :cells, Admin::TableCellComponent
end
