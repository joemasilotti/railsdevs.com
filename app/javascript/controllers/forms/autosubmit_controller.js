import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

export default class extends Controller {
  static targets = ["submit"]

  initialize() {
    this.submit = debounce(this.submit.bind(this), 200)
  }

  connect() {
    this.submitTarget.hidden = true
  }

  hideValidationMessage(event) {
    event.stopPropagation()
    event.preventDefault()
  }

  submit() {
    this.submitTarget.click()
  }
}
