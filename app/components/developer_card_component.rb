class DeveloperCardComponent < ApplicationComponent
  with_collection_parameter :developer

  def initialize(developer:)
    @developer = developer
  end

  def hero
    @developer.hero
  end

  def bio
    @developer.bio
  end
end
