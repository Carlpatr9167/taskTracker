import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]

  connect() {
    this.update()
    this.timer = window.setInterval(() => this.update(), 60_000)
  }

  disconnect() {
    window.clearInterval(this.timer)
  }

  update() {
    const now = new Date()

    this.displayTarget.textContent = now.toLocaleTimeString(undefined, {
      hour: "numeric",
      minute: "2-digit",
      hour12: true,
    })
    this.displayTarget.dateTime = now.toISOString()
  }
}
