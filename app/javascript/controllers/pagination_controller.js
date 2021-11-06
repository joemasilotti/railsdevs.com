import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["entries", "links"]

  initialize() {
    const options = {rootMargin: "200px"}
    this.intersectionObserver = new IntersectionObserver((entries) => this.processIntersectionEntries(entries), options)
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
    const nextPage = this.linksTarget.querySelector("a[rel='next']")
    if (nextPage == null) { return }

    const url = nextPage.href
    get(url, {responseKind: "turbo-stream"})
  }
}
