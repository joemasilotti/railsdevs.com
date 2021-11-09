class DeveloperOpenGraphTagsComponent < ViewComponent::Base
  def initialize(developer:)
    @developer = developer
  end

  def twitter
    "@#{@developer.twitter}" if @developer.twitter.present?
  end
end
