import { Controller } from "@hotwired/stimulus";
import { get_importmap } from "utils/get_importmap";

export default class extends Controller {
  static values = { id: String, bodyClass: String, contentCss: Array };

  async connect() {
    this.setIdToTextarea();
    await this.mountTinymce();
  }

  unmount() {
    tinymce.remove(this.selector);
  }

  get selector() {
    return `#${this.idValue}`;
  }

  setIdToTextarea() {
    const textareas = this.element.getElementsByTagName("textarea");
    if (textareas.length != 1)
      throw new Error("wysiwyg_controller shuld have 1 textarea");
    const textarea = textareas[0];
    textarea.id = this.idValue;
  }

  language = "ja";

  get languageUrl() {
    if (this._languageUrl == null) {
      const importmap = get_importmap();
      this._languageUrl =
        importmap.imports[`tinymce_languages/${this.language}`];
    }
    return this._languageUrl;
  }

  plugins = [
    "autoresize",
    "link",
    "table",
    "lists",
    "paste",
    "codesample",
    "code",
  ];

  toolbar = [
    "undo redo",
    "alignleft aligncenter alignright",
    "h2 h3",
    "bold italic underline strikethrough",
    "forecolor backcolor link",
    "bullist numlist table codesample",
    "code",
  ].join(" | ");

  get minHeight() {
    return this.element.clientHeight;
  }

  contentType =
    "@import url('https://fonts.googleapis.com/css2?family=Kosugi&family=Noto+Sans+JP&display=swap');";

  async mountTinymce() {
    await tinymce.init({
      language: this.language,
      language_url: this.languageUrl,

      selector: this.selector,
      menubar: false,
      statusbar: false,

      body_class: this.bodyClassValue,
      content_css: this.contentCssValue,
      content_style: this.contentType,

      min_height: this.minHeight,
      autoresize_bottom_margin: 0,

      plugins: this.plugins,
      toolbar: this.toolbar,
      toolbar_sticky: true,

      default_link_target: "_blank",
      link_default_protocol: "https",
      target_list: [{ text: "New window", value: "_blank" }],
      link_title: false,

      table_appearance_options: false,
      table_advtab: false,
      table_cell_advtab: false,
      table_row_advtab: false,
    });
  }
}
