import { Controller } from "@hotwired/stimulus"
import Clipboard from "../src/clipboard"

export default class extends Controller {
  static classes = ["visibility"]
  static targets = ["toggleable"]
  static values = {
    content: String,
    toggleTimeout: {type: Number, default: 2000}
  }

  copy(event) {
    event.preventDefault()
    Clipboard.copyHTML(this.contentValue)
  }

  toggle() {
    this.toggleHidden()
    setTimeout(() => {
      this.toggleHidden()
    }, this.toggleTimeoutValue)
  }

  toggleHidden() {
    this.toggleableTargets.forEach((toggleable) => {
      toggleable.classList.toggle(this.visibilityClass)
    })
  }
}
