import { Controller } from "@hotwired/stimulus"
import Combobox from "@github/combobox-nav"

export default class extends Controller {
  static targets = ["input", "list"]

  disconnect() {
    this.combobox?.destroy()
  }

  listTargetConnected() {
    this.start()
  }

  start() {
    this.combobox?.destroy()

    if (this.hasListTarget) {
      this.combobox = new Combobox(this.inputTarget, this.listTarget)
      this.combobox.start()
    }
  }

  stop() {
    this.combobox?.stop()
  }

  commit(event) {
    event.target.click()
  }
}
