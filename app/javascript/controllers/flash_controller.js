import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { dismissAfter: { type: Number, default: 5000 } }

  connect() {
    this.timeout = window.setTimeout(() => this.dismiss(), this.dismissAfterValue)
  }

  disconnect() {
    window.clearTimeout(this.timeout)
  }

  dismiss() {
    this.element.classList.add("flash-region--dismissed")

    this.element.addEventListener(
      "transitionend",
      () => {
        this.element.remove()
      },
      { once: true }
    )

    // Fallback if transitions are disabled
    window.setTimeout(() => {
      if (this.element.isConnected) this.element.remove()
    }, 500)
  }
}
