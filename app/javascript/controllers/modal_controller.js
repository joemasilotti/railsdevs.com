import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]
  static values = {toggleTimeout: {type: Number, default: 1000}}

  closeOnEsc(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  connect() {
    document.addEventListener("keydown", this.closeOnEsc)
  }

  disconnect() {
    document.removeEventListener("keydown", this.closeOnEsc)
  }

  hideModal() {
    setTimeout(() => {
      this.close()
    }, this.toggleTimeoutValue)
  }

  close() {
    this.modalTarget.remove()
  }
}
