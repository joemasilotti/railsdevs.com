import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]
  static values = {toggleTimeout: {type: Number, default: 1000}}

  hideModal() {
    setTimeout(() => {
      this.modalTarget.remove()
    }, this.toggleTimeoutValue)
  }
}
