// Entry point for the build script in your package.json
import "./controllers"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
