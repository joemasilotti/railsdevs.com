import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["redirecting"]
  static values = {url: String}

  connect() {
    this.redirectingTarget.remove()
    window.location = this.urlValue
  }
}
