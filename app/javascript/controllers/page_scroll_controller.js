import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    requestAnimationFrame(() => {
      this.element.scrollIntoView(false)
    })
  }
}
