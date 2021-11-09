# frozen_string_literal: true

class DeveloperSocialMetaTagsComponent < ViewComponent::Base
  def initialize(developer:)
    @developer = developer
  end
end
