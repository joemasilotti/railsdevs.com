import { Controller } from "@hotwired/stimulus"
// import { Turbo } from "@hotwired/turbo";

export default class extends Controller {
  static targets = ["dropdown", "input", "pillContainer"];

  connect() {
    console.log("DropdownPillController connected");
  }

  addPill(domId) {
    const template = document.getElementById(`specialty_${domId}-template`)
    const content = template.content.cloneNode(true)

    this.pillContainerTarget.appendChild(content)
  }

  removePill() {
    this.element.remove()
  }


  onSpecialityClick(event) {
    event.preventDefault();
    const domId = event.currentTarget.dataset.value;
    this.addPill(domId);
    this.inputTarget.value = "";
    this.dropdownTarget.innerHTML = "";
  }
}
