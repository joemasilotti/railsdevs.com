class Admin::BasicLinkGroupComponent < ApplicationComponent
  renders_many :links, Admin::BasicLinkComponent
end
