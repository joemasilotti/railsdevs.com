module Admin
  class ListComponent < ApplicationComponent
    renders_one :cta, Admin::Forms::ButtonLinkComponent
    renders_many :items, ListItemComponent
  end
end
