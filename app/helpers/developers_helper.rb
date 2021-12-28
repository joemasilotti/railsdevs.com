module DevelopersHelper
  def self.sanitize_skills(skills)
    skills.split(",").map(&:strip).reject(&:blank?).join(", ")
  end
end
