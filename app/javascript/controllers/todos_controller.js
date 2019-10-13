import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["title", "todoList", "todoErrors"];

  onAddSuccess(event) {
    let [data, status, xhr] = event.detail;
    this.todoListTarget.innerHTML += xhr.response;
    this.titleTarget.value = "";
    this.todoErrorsTarget.innerText = "";
  }

  onAddError(error) {
    let [data, status, xhr] = event.detail;
    this.todoErrorsTarget.innerHTML = xhr.response;
  }
}
