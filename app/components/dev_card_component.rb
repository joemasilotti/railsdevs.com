class DevCardComponent < ApplicationComponent
  def initialize(developer:)
    @developer = developer
  end

  def hero
    @developer.hero
  end

  def bio
    truncate(@developer.bio, length: 300)
  end
end
