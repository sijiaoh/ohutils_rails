import { Controller } from "@hotwired/stimulus";
import autosize from "autosize";

export default class extends Controller {
  static targets = ["textArea"];

  connect() {
    autosize(this.textAreaTarget);
  }
}
