import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "tabindex" ]

  connect() {
    if (window.innerWidth < 768) {
      this.viewPortWidth();
    }
  }

	viewPortWidth() {   
    this.tabindexTargets.setAttribute('tabindex', -1);
  }
}
