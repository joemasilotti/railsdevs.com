import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["activity", "image", "error"]
  static classes = ["visibility", "loading"]

  select(event) {
    const file = event.currentTarget.files[0]
    this.#createPreview(file)
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
  
  #createPreview (file) {
    const img = this.imageTarget;
    
    // Browser may not support MediaSource
    if (!("MediaSource" in window)) {
      this.#createPreviewFallback(file)
      return
    }
    
    const mediaSource = new MediaSource();
    
    // Older browsers may not have srcObject
    if ('srcObject' in img) {
      try {
        img.srcObject = mediaSource;
        return
      } catch (err) {
        if (err.name !== "TypeError") {
          throw err;
        }
        // Even if they do, they may only support MediaStream
        this.#createPreviewFallback(file)
        return
      }
    }
      
    this.#createPreviewFallback(file)
  }
  
  #createPreviewFallback (file) {
    const url = URL.createObjectURL(file)
    this.imageTarget.src = url
    this.imageTarget.srcset = url
  }
}
