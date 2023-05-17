import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="attach-template-tags"
export default class extends Controller {
  static targets = ["parentElement"]

  connect() {
    this.attachTemplateTags()
    this.hideElements()
  }

  attachTemplateTags() {
    const templateTags = document.querySelectorAll("template.when-javascript-enabled")
    templateTags.forEach((templateTag) => {
      const clonedNode = templateTag.content.cloneNode(true);
      this.parentElementTarget.appendChild(clonedNode);
    })
  }

  hideElements() {
    const elementsToHide = document.querySelectorAll(".hide-when-javascript-enabled")
    elementsToHide.forEach((elementToHide) => {
      elementToHide.classList.add("hidden")
    })
  }
}
