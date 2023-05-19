import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["dropdown", "input", "pillContainer", "option"];

  connect() {
    this.populatePillsFromCheckedCheckboxes()
  }

  removePill(event) {
    event.currentTarget.remove()
    this.uncheckCheckbox(event.currentTarget.dataset.specialtyId)
  }

  handleSpecialitySelection(event) {
    event.preventDefault()

    this.addPill(event.currentTarget.dataset.value)
    this.clearInputAndDropdown()
  }

  // utility methods

  get checkedCheckboxes() {
    return document.querySelectorAll("div[id=specialties-accordion] input[type=checkbox]:checked");
  }

  isPillDisplayed(domId) {
    return document.getElementById(`specialty_${domId}`) !== null
  }

  checkCheckbox(domId) {
    const checkbox = document.getElementById(`specialty_ids_${domId}`);
    checkbox.checked = true
  }

  uncheckCheckbox(domId) {
    const checkbox = document.getElementById(`specialty_ids_${domId}`);
    checkbox.checked = false
  }

  clearInputAndDropdown() {
    this.inputTarget.value = "";
    this.dropdownTarget.innerHTML = "";
  }

  addPill(value) {
    if (!this.isPillDisplayed(value)) {
      this.createPill(value)
      this.checkCheckbox(value)
    }
  }

  createPill(value) {
    const id = `specialty_${value}-template`
    const template = document.getElementById(id);
    const content = template.content.cloneNode(true)
    this.pillContainerTarget.appendChild(content)
  }

  populatePillsFromCheckedCheckboxes() {
    this.checkedCheckboxes.forEach((checkedCheckbox) => {
      this.addPill(checkedCheckbox.value)
    })
  }

  optionTargetConnected(element) {
    if (this.isPillDisplayed(element.dataset.value)) {
      element.parentElement.remove()
    }
  }
}
