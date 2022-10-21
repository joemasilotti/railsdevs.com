import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:load", this.trackPageView.bind(this), {once: true})
  }

  trackPageView() {
    if (window.fathom && this.shouldTrackPageView) {
      window.fathom.trackPageview()
    }
  }

  // Add `<meta id="ignorePageview">` to the DOM to *not* track a page view to Fathom.
  get shouldTrackPageView() {
    return !document.querySelector("#ignorePageView")
  }
}
