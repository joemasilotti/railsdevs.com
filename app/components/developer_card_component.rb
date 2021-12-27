class DeveloperCardComponent < ApplicationComponent
  with_collection_parameter :developer

  attr_reader :developer

  def initialize(developer:)
    @developer = developer
  end

  def hero
    @developer.hero
  end

  def bio
    @developer.bio
  end

  def technical_skills
    @developer.technical_skills
  end

  def pivot_skills
    @developer.pivot_skills
  end
end
