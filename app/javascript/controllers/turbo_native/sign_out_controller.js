import { Controller } from "@hotwired/stimulus"
import Bridge from "../../src/turbo_native/bridge"

export default class extends Controller {
  signOut(event) {
    if (Bridge.isTurboNativeApp) {
      event.preventDefault()
      event.stopImmediatePropagation()
      window.TurboNativeBridge.postMessage("signOut")
    }
  }
}
