import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["message"];

  connect() {
    setTimeout(() => {
      if (this.hasMessageTarget) {
        this.messageTarget.remove();
      }
    }, 5000)
  }

  close() {
    if (this.hasMessageTarget) {
      this.messageTarget.remove();
    }
  }
}
