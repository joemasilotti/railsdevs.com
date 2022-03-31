import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "scrollPoint", "messageForm" ]

  connect() {
    // this.scrollToBottomOfElement()
    // this.scrollToTarget()
    console.log("connected")

  }

  scrollMe() {
    if (this.messageFormTarget.complete) {
      this.scrollPointTarget.scrollIntoView(false)
    } else {
      this.messageFormTarget.loaded.then(() => {
        console.log("it's loaded")
        this.scrollPointTarget.scrollIntoView(false)
      })
    }
  }

  scrollPointTargetConnected(element) {
    // if element.loaded
    // console.log("Target Connected")
    this.scrollPointTarget.scrollIntoView(false)
    // element.scrollIntoView(false)
  }

  scrollToTarget() {
    console.log("Scrolled YEAH!")
    // this.scrollPointTarget.scrollIntoView(false)
    this.scrollPointTarget.scrollIntoView(false)
    console.log("turbo", Turbo)
  }
}
