import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "completed" ];

  toggle(event) {
    // Get the value of the checkbox, and put it into a FormData object
    let formData = new FormData();
    formData.append("todo[completed]", this.completedTarget.checked);

    fetch(this.data.get("update-url"), {
      body: formData,
      method: "PATCH",
      dataType: "script",
      // Ensure we send the session cookie and the CSRF protection token.
      // That will prevent the ActionController::InvalidAuthenticityToken error.
      credentials: "include",
      headers: {
        "X-CSRF-Token": Rails.csrfToken()
      }
    })
    .then((response) => {
      if (response.status != 204) {
        event.target.checked = !event.target.checked;
      }
    });
  }
}
