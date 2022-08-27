// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller

import { application } from "./application"

import AccessibilityController from "./accessibility_controller.js"
application.register("accessibility", AccessibilityController)

import Analytics__EventsController from "./analytics/events_controller.js"
application.register("analytics--events", Analytics__EventsController)

import ClipboardController from "./clipboard_controller.js"
application.register("clipboard", ClipboardController)

import FileUploadController from "./file_upload_controller.js"
application.register("file-upload", FileUploadController)

import FormController from "./form_controller.js"
application.register("form", FormController)

import KeyboardShortcutController from "./keyboard_shortcut_controller.js"
application.register("keyboard-shortcut", KeyboardShortcutController)

import PageScrollController from "./page_scroll_controller.js"
application.register("page-scroll", PageScrollController)

import SafariImageFixController from "./safari_image_fix_controller.js"
application.register("safari-image-fix", SafariImageFixController)

import ToggleController from "./toggle_controller.js"
application.register("toggle", ToggleController)

import TurboNative__InAppPurchasesController from "./turbo_native/in_app_purchases_controller.js"
application.register("turbo-native--in-app-purchases", TurboNative__InAppPurchasesController)

import TurboNative__SignOutController from "./turbo_native/sign_out_controller.js"
application.register("turbo-native--sign-out", TurboNative__SignOutController)
