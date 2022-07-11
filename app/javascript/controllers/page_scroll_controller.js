import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    onConnect: { type: Boolean, default: true },
    focus: { type: Boolean, default: true },
  }

  connect() {
    requestAnimationFrame(() => {
      if (this.onConnectValue) this.scrollIntoView()
      if (this.focusValue) this.focus()
    })
  }

  // actions

  scrollIntoView() {
    this.element.scrollIntoView(false)
  }

  focus() {
    // focus on the first input , select or textarea in the element
    this.element.querySelector("input, select, textarea").focus()
  }
}