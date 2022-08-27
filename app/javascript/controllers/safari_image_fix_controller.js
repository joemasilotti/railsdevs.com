// Fixes an issue in Safari where navigating via Turbo doesn't load the correct srcset on an <img> tag.
// https://github.com/hotwired/turbo/issues/331#issuecomment-956019113

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    this.boundRefreshImages = this.refreshImages.bind(this)
  }

  connect() {
    document.addEventListener("turbo:render", this.boundRefreshImages)
    document.addEventListener("turbo:frame-load", this.boundRefreshImages)
  }

  disconnect() {
    document.removeEventListener("turbo:render", this.boundRefreshImages)
    document.removeEventListener("turbo:frame-load", this.boundRefreshImages)
  }

  refreshImages(event) {
    if (this.isSafari) {
      this.imageTagsWithSrcSet(event.target).forEach(img => {
        console.debug("Fixing <img>...")
        img.outerHTML = img.outerHTML
      })
    }
  }

  get isSafari() {
    return navigator.userAgent.match(/Version\/[\d.]+.*Safari/)
  }

  imageTagsWithSrcSet(target) {
    return target.querySelectorAll("img[srcset]")
  }
}
