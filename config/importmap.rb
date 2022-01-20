# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin_all_from "app/javascript/utils", under: "utils"
pin_all_from "vendor/javascript/tinymce_languages", under: "tinymce_languages"

pin "google_analytics", to: "google_analytics.js"

pin "marked", to: "https://ga.jspm.io/npm:marked@4.0.10/lib/marked.esm.js"
pin "mermaid", to: "https://ga.jspm.io/npm:mermaid@8.13.8/dist/mermaid.esm.min.mjs"
