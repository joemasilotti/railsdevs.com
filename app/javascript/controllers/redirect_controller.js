import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["redirecting"]
  static values = {url: String}

  connect() {
    this.redirectingTarget.remove()
    Turbo.visit(this.urlValue)
    // window.location = this.urlValue
  }
}
