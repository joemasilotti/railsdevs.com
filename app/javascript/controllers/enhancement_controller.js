import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["baseline", "enhancement"]
  static classes = ["visibility"]

  connect() {
    if (this.hasEnhancementTarget) {
      this.enhancementTarget.classList.remove("hidden")
    }

    if (this.hasBaselineTarget) {
      this.baselineTarget.classList.add("hidden")
    }
  }
}
