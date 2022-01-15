import { Controller } from "@hotwired/stimulus";
import { marked } from "marked";
import mermaid from "mermaid";

export default class extends Controller {
  static values = { content: String };

  connect() {
    const renderer = new marked.Renderer();
    const renderer2 = new marked.Renderer();
    renderer.code = (code, lang, ...args) => {
      if (lang === "mermaid")
        return ['<div class="mermaid">', code, "</div>"].join("");
      return renderer2.code(code, lang, ...args);
    };

    // c++ in Prism.js is cpp.
    const content = this.contentValue.replace("```c++", "```cpp");

    this.element.innerHTML = marked(content, {
      breaks: true,
      renderer,
    });

    mermaid.init(".mermaid");
    window.Prism.highlightAllUnder(this.element);

    // Hide source file from DebTools.
    this.contentValue = "";
  }
}
