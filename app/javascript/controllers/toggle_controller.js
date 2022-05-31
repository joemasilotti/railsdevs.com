import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element"]
  static classes = ["visibility"]
  static values = {"toggleOnConnect": Boolean}

  connect() {
    if (this.toggleOnConnectValue) {
      this.toggle()
    }
  }

  toggle(event) {
    event && event.preventDefault()

    this.elementTargets.forEach(element => {
      element.classList.toggle(this.visibilityClass)
    })
  }
}
