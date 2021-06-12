// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("jquery");
require("@rails/ujs").start()
require("turbolinks").start();
require("@rails/activestorage").start();

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
require("stylesheets/application.scss")

//= require active_admin/base
// Support component names relative to this directory:
var ReactRailsUJS = require("react_ujs");
var componentRequireContext = require.context("components", true);
ReactRailsUJS.useContext(componentRequireContext);
