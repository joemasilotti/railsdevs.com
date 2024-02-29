module OffersHelper
  def offer_state_notice(offer_state)
    case offer_state
    when "proposed" then t("offers_helper.offer_state_notice.proposed_an_offer")
    when "accepted" then accepted_offer_notice
    when "declined" then declined_offer_notice
    else
      raise ArgumentError, "Unknown offer sate"
    end
  end

  private

  def accepted_offer_notice
    (
      t("offers_helper.accepted_offer_notice.accepted_the_offer") +
        inline_svg_tag("icons/solid/check.svg", class: "h-5 w-5 text-green-600", aria_hidden: true)
    ).html_safe
  end

  def declined_offer_notice
    (
      t("offers_helper.declined_offer_notice.declined_the_offer") +
        inline_svg_tag("icons/solid/x_circle.svg", class: "h-5 w-5 text-red-600", aria_hidden: true)
    ).html_safe
  end
end
