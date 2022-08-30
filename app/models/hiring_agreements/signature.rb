module HiringAgreements
  class Signature < ApplicationRecord
    belongs_to :user
    belongs_to :term, foreign_key: "hiring_agreements_term_id"

    validates :agreement, acceptance: true
  end
end
