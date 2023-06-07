class AttachSignedHiringAgreementJob < ApplicationJob
  queue_as :default

  def perform(signature_id)
    @signature = HiringAgreements::Signature.find(signature_id)
    pdf = generate_pdf
    attach_pdf(pdf)
  end

  private

  def generate_pdf
    ApplicationController.render(
      template: "hiring_agreements/terms/show",
      formats: :pdf,
      assigns: {term: @signature.term, signature: @signature},
      encoding: "UTF-8"
    )
  end

  def attach_pdf(pdf)
    @signature.signed_pdf.attach(
      io: StringIO.new(pdf),
      filename: "RailsDevs hiring agreement.pdf",
      content_type: "application/pdf"
    )
  end
end
