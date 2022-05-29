import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["responseArea", "label"]

  updateUi(event) {
    var dropdown = event.target

    this.toggleResponseVisibility(dropdown)
    console.log(this.labelTarget)
    this.labelTarget.textContent = dropdown.options[dropdown.selectedIndex].text
  }

  toggleResponseVisibility(dropdown) {
    if(dropdown.value != "") {
      this.responseAreaTarget.style.display = "block"
    } else {
      this.responseAreaTarget.style.display = "none"
    }
  }
}
