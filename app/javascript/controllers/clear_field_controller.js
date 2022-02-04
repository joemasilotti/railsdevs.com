import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clear-field"
export default class extends Controller {
  static values = {
    target: String
  }
  connect() {
    this.target = document.querySelector(this.targetValue)
  }

  clear() {
    this.target.value = ""
  }
}
