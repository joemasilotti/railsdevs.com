class Admin::ListComponent < ApplicationComponent
  renders_many :items, Admin::ListItemComponent
end
