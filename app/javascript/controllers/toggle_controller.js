import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element"]
  static classes = ["visibility"]

  toggle(event) {
    event.preventDefault()

    this.elementTargets.forEach(element => {
      element.classList.toggle(this.visibilityClass)
    })
  }
}

/*
  Mobile menu, show/hide based on menu open state.

  Entering: "duration-150 ease-out"
  From: "opacity-0 scale-95"
  To: "opacity-100 scale-100"
  Leaving: "duration-100 ease-in"
  From: "opacity-100 scale-100"
  To: "opacity-0 scale-95"
*/
