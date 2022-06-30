import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.scrollIntoView(false)
    }, 0);
  }
}
