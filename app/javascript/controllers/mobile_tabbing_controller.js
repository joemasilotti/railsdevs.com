import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	viewPortWidth() {
		var viewPortWidth = window.innerWidth;

    if (viewPortWidth < 768) {
      document.getElementsByClassName('tab-index-mobile').setAttribute('tabindex', '-1');
    }
  }
}