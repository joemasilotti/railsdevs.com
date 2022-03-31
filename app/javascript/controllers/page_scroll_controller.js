import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:load", this.scrollIntoView)
  }

  disconnect() {
    document.removeEventListener("turbo:load", this.scrollIntoView)
  }

  scrollIntoView() {
    this.element.scrollIntoView(false)
  }
}
