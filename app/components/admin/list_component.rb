module Admin
  class ListComponent < ApplicationComponent
    renders_many :items, ListItemComponent
  end
end
