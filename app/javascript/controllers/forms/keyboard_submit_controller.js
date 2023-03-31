import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit"]

  submit(event) {
    if ((event.ctrlKey == true || event.metaKey == true) && event.code == "Enter") {
      event.preventDefault()
      this.submitTarget.click()
    }
  }
}
