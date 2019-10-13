import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["title", "todoList"];

  onAddSuccess(event) {
    let [data, status, xhr] = event.detail;
    this.todoListTarget.innerHTML += xhr.response;
    this.titleTarget.value = "";
  }
}
