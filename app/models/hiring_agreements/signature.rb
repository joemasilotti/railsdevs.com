module HiringAgreements
  class Signature < ApplicationRecord
    belongs_to :user
    belongs_to :term, foreign_key: "hiring_agreements_term_id"

    has_one_attached :signed_pdf

    validates :agreement, acceptance: true
    validates :full_name, presence: true, on: :create

    after_create_commit :attach_signed_pdf

    private

    def attach_signed_pdf
      AttachSignedHiringAgreementJob.perform_later(id)
    end
  end
end
