import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit(event) {
    if ((event.ctrlKey == true || event.metaKey == true) && event.code == "Enter") {
      event.preventDefault()
      this.element.requestSubmit()
    }
  }
}
