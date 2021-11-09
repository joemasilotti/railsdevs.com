class DeveloperOpenGraphTagsComponent < OpenGraphTagsComponent
  def initialize(developer:)
    @developer = developer
  end

  def title
    @developer.hero
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
