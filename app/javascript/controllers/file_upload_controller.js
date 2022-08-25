import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["activity", "image", "error"]
  static classes = ["visibility", "loading"]

  select(event) {
    const file = event.currentTarget.files[0]
    this.imageTarget.src = window.URL.createObjectURL(file)
    this.imageTarget.srcset = window.URL.createObjectURL(file)
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
