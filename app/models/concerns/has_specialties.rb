module HasSpecialties
  extend ActiveSupport::Concern

  included do
    has_many :specialty_tags
    has_many :specialties, -> { order(:name) }, through: :specialty_tags, dependent: :destroy
  end
end
