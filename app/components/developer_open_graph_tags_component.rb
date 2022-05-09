class DeveloperOpenGraphTagsComponent < OpenGraphTagsComponent
  def initialize(developer:)
    @developer = developer
    @title = @developer.hero
    @turbo_native_title = I18n.t(".turbo_native_title")
  end

  def description
    @developer.bio
  end

  def url
    developer_url(@developer)
  end

  def image
    rails_blob_url(@developer.avatar) if @developer.avatar.attached?
  end

  def twitter
    "@#{@developer.twitter}" if @developer.twitter.present?
  end
end
