module HasSpecialties
  extend ActiveSupport::Concern

  included do
    has_many :specialty_tags
    has_many :specialties, -> { visible }, through: :specialty_tags, dependent: :destroy

    validates :specialties, length: {maximum: 5}
  end
end
