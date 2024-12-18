import "core-js/stable";
import "regenerator-runtime/runtime";
import "./style.scss";

const id = "$PROJECTID"
const script_id = "script_" + id
const sel = "#" + id
const script_sel = "#" + script_id

/*Gets the correct base URL regardless of whether we're on the test apps.cbpp.org page or the real cbpp.org page*/
const url_base = document.querySelector(script_sel).src.replace(/js\/app(\.min)*\.js/g,"").split("?")[0]

document.write("Hello world!")