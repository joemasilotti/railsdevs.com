// Entry point for the build script in your package.json
import "./controllers"
import "./src/clipboard"
import "./src/fathom"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
