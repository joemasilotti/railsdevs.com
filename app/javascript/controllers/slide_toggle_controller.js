import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "background", "indicator"]
  static classes = ["indicatorOn", "indicatorOff", "backgroundOn", "backgroundOff"]
  static values = { "enabled": { type: Boolean, default: false } }

  connect() {
    this.setClasses()
  }

  toggle() {
    this.toggleClasses()

    this.enabledValue = !this.enabledValue
    if(this.hasCheckboxTarget) {
      this.checkboxTarget.checked = this.enabledValue
    }
  }

  toggleClasses() {
    this.backgroundTarget.classList.toggle(this.backgroundOnClass)
    this.backgroundTarget.classList.toggle(this.backgroundOffClass)

    this.indicatorTarget.classList.toggle(this.indicatorOnClass)
    this.indicatorTarget.classList.toggle(this.indicatorOffClass)
  }

  setClasses() {
    if(this.enabledValue) {
      this.backgroundTarget.classList.toggle(this.backgroundOnClass)
      this.indicatorTarget.classList.toggle(this.indicatorOnClass)
    } else {
      this.backgroundTarget.classList.toggle(this.backgroundOffClass)
      this.indicatorTarget.classList.toggle(this.indicatorOffClass)
    }
  }

  processResponse(event) {
    if(!event.detail.fetchResponse.response.ok) {
      this.toggle()
    }
  }
}
