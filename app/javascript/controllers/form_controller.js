import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  cmdEnterSubmit(event) {
    if ((event.ctrlKey == true || event.metaKey == true) && event.code == 'Enter') {
      event.preventDefault()
      this.element.requestSubmit()
    }
  }
}
