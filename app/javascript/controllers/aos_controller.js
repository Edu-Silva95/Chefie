import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (window.AOS) {
      window.AOS.init({
        duration: 700,
        easing: 'ease-out-cubic',
        once: true
      })
    } else {
      console.warn("AOS not loaded yet")
    }
  }
}
