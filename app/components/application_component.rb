class ApplicationComponent < ViewComponent::Base
  include Classy::Yaml::ComponentHelpers
  self.default_url_options = Rails.application.routes.default_url_options
end
