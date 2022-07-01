import { Controller } from "@hotwired/stimulus"
import Bridge from "../../src/turbo_native/bridge"

export default class extends Controller {
  static values = {
    plan: String
  }

  purchase(event) {
    if (Bridge.isTurboNativeApp) {
      event.preventDefault()
      event.stopImmediatePropagation()
      Bridge.postMessage("purchase", {plan: this.planValue})
    }
  }
}
