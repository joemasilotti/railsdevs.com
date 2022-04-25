import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element", "chevron"]
  static classes = ["visibility", "chevron"]

  toggle(event) {
    event && event.preventDefault()

    this.elementTargets.forEach(element => {
      element.classList.toggle(this.visibilityClass)
    })

    this.chevronTargets.forEach(element => {
      element.classList.toggle(this.chevronClasses)
    })
  }
}
