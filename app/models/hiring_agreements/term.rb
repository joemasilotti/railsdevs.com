module HiringAgreements
  class Term < ApplicationRecord
    include Activatable

    validates :body, presence: true

    has_many :signatures, foreign_key: "hiring_agreements_term_id", dependent: :destroy

    def self.signed_by?(user)
      active.signatures.exists?(user:)
    end
  end
end
