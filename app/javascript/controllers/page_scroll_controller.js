import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollToBottom()
  }

  scrollToBottom() {
    this.element.scrollIntoView(false)
  }
}
