import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mac", "windows"]
  static classes = ["visibility"]

  connect() {
    if (navigator.userAgent.indexOf("Mac") != -1) {
      this.macTarget.classList.remove(this.visibilityClasses)
      this.element.classList.remove(this.visibilityClasses)
    } else if (navigator.userAgent.indexOf("Windows") != -1) {
      this.windowsTarget.classList.remove(this.visibilityClasses)
      this.element.classList.remove(this.visibilityClasses)
    }
  }
}
