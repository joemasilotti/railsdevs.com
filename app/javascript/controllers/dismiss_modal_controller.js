import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {"url": String}

  connect() {
    window.TurboNativeBridge.postMessage("dismissModal")
    Turbo.visit(this.urlValue, {action: "replace"})
  }
}
