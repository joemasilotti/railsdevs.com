class DevCardComponent < ApplicationComponent
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
