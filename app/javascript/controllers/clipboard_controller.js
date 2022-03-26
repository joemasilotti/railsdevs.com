import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleable"];

  copy({ target: { value } }) {
    navigator.clipboard.writeText(value);
  }

  toggle() {
    this.toggleHidden();
    setTimeout(() => {
      this.toggleHidden();
    }, 2000);
  }

  toggleHidden() {
    this.toggleableTargets.forEach((toggleable) => {
      toggleable.classList.toggle("hidden");
    });
  }
}
