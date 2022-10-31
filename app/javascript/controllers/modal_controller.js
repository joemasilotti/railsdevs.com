import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]
  static values = { toggleTimeout: {type: Number, default: 1000} }

  hideModal() {
    // Remove src reference from parent frame element
    // Without this, turbo won't re-open the modal on subsequent click
    setTimeout(() => {
      this.element.parentElement.removeAttribute("src")
      this.modalTarget.remove()
    }, this.toggleTimeoutValue)
  }

}