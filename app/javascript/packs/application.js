// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as Turbo from "@hotwired/turbo";
import $ from 'jquery'
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

window.jQuery = window.$ = $; // for console access
const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

require('fomantic-ui-css/semantic.css');
require('fomantic-ui-css/semantic.js');

Rails.start()

// Turbo sometimes leaves buttons disabled after clicking + going back
document.documentElement.addEventListener('turbo:load', () => {
  document.querySelectorAll('.ui.button[disabled]').forEach((button) => {
    button.disabled = false
  })
})

console.log("Welcome to Webpacker!")
