module Admin
  class BasicLinkGroupComponent < ApplicationComponent
    renders_many :links, BasicLinkComponent
  end
end
