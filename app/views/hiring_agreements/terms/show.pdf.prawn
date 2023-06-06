prawn_document do |pdf|
  pdf.text I18n.t("hiring_agreements.signatures.new.title"), size: 16
  pdf.text I18n.t("hiring_agreements.signatures.new.description", last_updated: @term.created_at.to_formatted_s(:calendar)), size: 14
  pdf.move_down 20

  pdf.text @term.body
  pdf.move_down(50)

  pdf.bounding_box([pdf.bounds.left, pdf.cursor], width: 200) do
    if @signature.present?
      pdf.font("Courier") { pdf.text @signature.full_name }
    end
    pdf.stroke_horizontal_rule
    pdf.move_down(10)
    pdf.text "Signature", size: 10
    pdf.move_down(30)

    if @signature.present?
      pdf.font("Courier") { pdf.text @signature.created_at.to_formatted_s(:calendar) }
    end
    pdf.stroke_horizontal_rule
    pdf.move_down(10)
    pdf.text "Date", size: 10
  end
end
