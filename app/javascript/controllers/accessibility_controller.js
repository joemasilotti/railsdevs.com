import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  toggleAriaExpanded() {
    const element = this.buttonTarget;
    const initialVal = element.getAttribute("aria-expanded")
    const toggledVal = initialVal === "true" ? "false" : "true"

    element.setAttribute("aria-expanded", toggledVal)
  }
}
