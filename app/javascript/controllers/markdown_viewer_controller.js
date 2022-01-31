import { Controller } from "@hotwired/stimulus";
import { marked } from "marked";
import mermaid from "mermaid";

export default class extends Controller {
  static values = { content: String };

  connect() {
    // Hide pure content from DebTools.
    this._content = this.contentValue;
    this.contentValue = "";

    this.observer = new IntersectionObserver(([entry]) => {
      if (!entry.isIntersecting) return;
      if (this.rendered != null) return;
      this.rendered = true;

      this.render();
    });
    this.observer.observe(this.element);
  }

  disconnect() {
    this.observer.unobserve(this.element);
  }

  render() {
    const renderer = new marked.Renderer();
    const renderer2 = new marked.Renderer();
    renderer.code = (code, lang, ...args) => {
      if (lang === "mermaid")
        return ['<div class="mermaid">', code, "</div>"].join("");
      return renderer2.code(code, lang, ...args);
    };

    // c++ in Prism.js is cpp.
    const content = this._content.replace("```c++", "```cpp");

    this.element.innerHTML = marked(content, {
      breaks: true,
      renderer,
    });

    mermaid.init(".mermaid");
    window.Prism.highlightAllUnder(this.element);
  }

  restoreContentValue() {
    this.contentValue = this._content;
  }
}
