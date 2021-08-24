// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"
// import "tailwindcss/tailwind.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import LiveSocket from "phoenix_live_view"
import { Socket } from "phoenix"

var $ = require( "jquery" );
let socket = new Socket("/ws")
let LiveHooks = {};

LiveHooks.MountTinyMCE = {
    mounted() {
        var elementId = "#" + $(".tiny-mce").attr("id");
        console.log("ELEMENT ID: ", elementId);
        tinymce.init({
            selector: elementId,
            height: 500,
            plugins: 'advcode casechange formatpainter linkchecker autolink lists advlist checklist media mediaembed pageembed permanentpen powerpaste table advtable tinymcespellchecker',
            toolbar: 'casechange bullist numlist checklist code formatpainter pageembed permanentpen table',
            toolbar_mode: 'floating',
            advlist_bullet_styles: 'default,circle,disc,square',
            advlist_number_styles: 'default,lower-alpha,lower-greek,lower-roman,upper-alpha,upper-roman'
        });
    },
  } 


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: LiveHooks, params: {_csrf_token: csrfToken}})
// let liveSocket = new LiveSocket("/live", Socket, { hooks: LiveHooks, logger: logger, params: { _csrf_token: csrfToken } })

// Connect if there are any LiveViews on the page
liveSocket.connect()

// Expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
// The latency simulator is enabled for the duration of the browser session.
// Call disableLatencySim() to disable:
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket
window.LiveHooks = LiveHooks;