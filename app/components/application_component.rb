class ApplicationComponent < ViewComponent::Base
  include Classy::Yaml::ComponentHelpers
  include UrlHelpersWithDefaultUrlOptions
end
