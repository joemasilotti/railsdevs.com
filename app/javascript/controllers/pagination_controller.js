import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = ["entries", "links"]

  initialize() {
    const options = { rootMargin: "200px" }

    this.intersectionObserver = new IntersectionObserver((entries) => this.processIntersectionEntries(entries), options)
  }

  connect() {
    this.intersectionObserver.observe(this.linksTarget)
  }

  disconnect() {
    this.intersectionObserver.unobserve(this.linksTarget)
  }

  linksTargetConnected() {
    this.intersectionObserver.observe(this.linksTarget)
  }

  processIntersectionEntries(entries) {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        this.loadMore()
      }
    })
  }

  loadMore() {
    let next_page = this.linksTarget.querySelector("a[rel='next']");
    if (next_page == null) {
      return
    }
    let url = next_page.href
    get(url, { responseKind: "turbo-stream" })
  }
}