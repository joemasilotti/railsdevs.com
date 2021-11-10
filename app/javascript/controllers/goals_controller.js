import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    goal: String
  }

  complete(event) {
    window.fathom.trackGoal(this.goalValue, 0)
  }
}
