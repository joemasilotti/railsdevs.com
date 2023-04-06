import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autofetch"
export default class extends Controller {
  static targets = ["input", "specialties"]

  onInputChange() {
    const query = this.inputTarget.value

    if (query.length > 0) {
      const url = `/specialties?query=${encodeURIComponent(query)}&turbo_frame=specialties_dropdown`
      this.specialtiesTarget.src = url
    } else {
      this.specialtiesTarget.innerHTML = ""
    }
  }
}
