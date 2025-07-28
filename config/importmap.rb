# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@rails/ujs", to: "@rails--ujs.js" # @7.1.3
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "aos", to: "https://cdn.jsdelivr.net/npm/aos@2.3.1/dist/aos.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/shared", under: "shared"
