import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element", "chevron"]
  static classes = ["open", "close"]
  static values = {
    open: {type: Boolean, default: false}
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
    this.chevronTargets.forEach(element =>{
      element.classList.remove("rotate-0")
      element.classList.add("rotate-180")
    })
  }

  toggleClose() {
    this.elementTargets.forEach(element => {
      this.hasOpenClass && element.classList.remove(this.openClasses)
      this.hasCloseClass && element.classList.add(this.closeClasses)
    })
    this.chevronTargets.forEach(element =>{
      element.classList.remove("rotate-180")
      element.classList.add("rotate-0")
    })
  }
}
