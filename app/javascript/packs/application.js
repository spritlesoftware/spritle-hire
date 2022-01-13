// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

global.toastr = require("toastr")

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../stylesheets/application"

require("../vendors/js/vendor.bundle.base")

require("../vendors/datatables.net/jquery.dataTables")
require("../vendors/datatables.net-bs4/dataTables.bootstrap4")

require("../js/off-canvas")
require("../js/hoverable-collapse")
require("../js/template")
require("../js/settings")
require("../js/todolist")

// require("../js/x-editable")

require("../js/custom/data-table")
require("../js/custom/file-upload")
require("../js/custom/login")

Rails.start()
// Turbolinks.start()
ActiveStorage.start()
