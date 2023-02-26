import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["activity", "image", "error"]
  static classes = ["visibility", "loading"]

  select(event) {
    const file = event.currentTarget.files[0]
    const objectUrl = window.URL.createObjectURL(file)
    this.imageTarget.src = objectUrl
    this.imageTarget.srcset = objectUrl
    // NOTE: Update the srcset of the <source> tag of the <picture> tag sub-element
    const picture = event.currentTarget.closest('div').querySelector('picture');
    if(picture) {
      const sources = picture.querySelectorAll('source')
      sources.forEach(source => {
        source.srcset = objectUrl
      });
    }
    this.imageTarget.classList.remove(this.visibilityClass)
    this.errorTarget.classList.add(this.visibilityClass)
  }

  start() {
    this.imageTarget.classList.add(this.loadingClass)
    this.activityTarget.classList.remove(this.visibilityClass)
    this.errorTarget.classList.add(this.visibilityClass)
  }

  error(event) {
    event.preventDefault()

    this.imageTarget.classList.remove(this.loadingClass)
    this.activityTarget.classList.add(this.visibilityClass)
    this.errorTarget.classList.remove(this.visibilityClass)
    console.error(event.detail.error)
  }
}
