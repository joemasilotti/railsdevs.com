import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  toggleAriaExpanded() {
    const element = this.buttonTarget;
    const initialVal = element.getAttribute("aria-expanded")
    const toggledVal = initialVal === "true" ? "false" : "true"

    element.setAttribute("aria-expanded", toggledVal)
  }

  trapModalFocus() {
    // add all the elements inside modal which are focusable
    const focusableElements =
      'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    const modal = document.querySelector("#mobileFilterModal")

    const firstFocusableElement = modal.querySelectorAll(focusableElements)[0]
    const focusableContent = modal.querySelectorAll(focusableElements)
    const lastFocusableElement = focusableContent[focusableContent.length - 1]

    document.addEventListener("keydown", function (e) {
      let isTabPressed = e.key === "Tab"

      if (!isTabPressed) {
        return
      }

      if (e.shiftKey) {
        if (document.activeElement === firstFocusableElement) {
          lastFocusableElement.focus()
          e.preventDefault()
        }
      } else {
        if (document.activeElement === lastFocusableElement) {
          firstFocusableElement.focus()
          e.preventDefault()
        }
      }
    })

    firstFocusableElement.focus()
  }

  focusBackToFilter() {
    const filterButton = document.querySelector("#filterButton")

    filterButton.focus()
  }
}
