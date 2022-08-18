class Admin::TableComponent < ApplicationComponent
  renders_many :headers, Admin::TableHeaderComponent
  renders_many :rows, Admin::TableRowComponent
end
