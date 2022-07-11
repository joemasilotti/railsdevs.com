import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    onConnect: { type: Boolean, default: true },
    focus: { type: Boolean, default: true },
    shouldScroll: { type: Boolean, default: true },
  }

  connect() {
    requestAnimationFrame(() => {
      if (this.shouldScrollValue) {
        if (this.onConnectValue) this.scrollIntoView()
        if (this.focusValue) this.focus()
      }

      // Persit scroll position when navigating backwards or forwards
      window.onpopstate = (e) => {
        this.shouldScrollValue = false
      }
    })
  }

  scrollIntoView() {
    this.element.scrollIntoView(false)
  }

  focus() {
    // Focus on the first input , select or textarea in the element
    this.element.querySelector("input, select, textarea").focus()
  }
}