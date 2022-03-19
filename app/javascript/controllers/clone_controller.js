import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["template"];

  append({ target }) {
    for (const { content } of this.templateTargets) {
      target.append(content.cloneNode(true));
    }
  }
}
