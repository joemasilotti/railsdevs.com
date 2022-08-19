class ApplicationComponent < ViewComponent::Base
  include Classy::Yaml::ComponentHelpers
  include UrlHelpersWithDefaultUrlOptions

  def align_class
    align == :right ? "text-right" : "text-left"
  end
end
