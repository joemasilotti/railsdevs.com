import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element"]
  static classes = ["open", "close"]
  static values = {
    open: { type: Boolean, default: false }
  }

  openValueChanged() {
    this.openValue ? this.toggleOpen() : this.toggleClose()
  }

  toggle(event) {
    event && event.preventDefault()
    this.openValue = !this.openValue
  }

  toggleOpen() {
    this.elementTargets.forEach(element => {
      this.hasCloseClass && element.classList.remove(this.closeClasses)
      this.hasOpenClass && element.classList.add(this.openClasses)
    })
  }

  toggleClose() {
    this.elementTargets.forEach(element => {
      this.hasOpenClass && element.classList.remove(this.openClasses)
      this.hasCloseClass && element.classList.add(this.closeClasses)
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
