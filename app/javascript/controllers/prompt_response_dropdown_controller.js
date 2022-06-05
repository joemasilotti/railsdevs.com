import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["responseArea", "label", "dropdown"]

  connect() {
    this.updateUi()
    this.element.scrollIntoView({ behavior: 'smooth' })
  }

  updateUi() {
    if(this.dropdownTarget.value != "") {
      this.responseAreaTarget.style.display = "block"
      this.labelTarget.textContent = this.dropdownTarget.options[this.dropdownTarget.selectedIndex].text
    } else {
      this.responseAreaTarget.style.display = "none"
    }
  }
}
