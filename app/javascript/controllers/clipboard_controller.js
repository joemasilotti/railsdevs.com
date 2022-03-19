import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  copy({ target: { value } }) {
    console.log(value);
    navigator.clipboard.writeText(value);
  }
}
