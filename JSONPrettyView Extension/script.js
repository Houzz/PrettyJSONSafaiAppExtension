var original
document.addEventListener("DOMContentLoaded", function(event) {
    if (document.contentType == "application/json") {
      document.addEventListener("contextmenu", handleContextMenu, false);
      if (document.getElementById("wrapper") == null) {
            original = document.body.children[0].innerHTML
            try {
                let obj = JSON.parse(original)
                document.body.innerHTML = "<div id='wrapper'></div>"
                var element = document.getElementById("wrapper")
                document.jsonTree = jsonTree.create(obj, element)
                document.jsonTree.limitedExpand(20)
            } catch(e) {
                window.alert("Error: " + e)
                return
            }
        }
    }
//    safari.extension.dispatchMessage("Hello World!");
});



safari.self.addEventListener("message", function(event) {
    if (event.name == "toggle") {
        if (document.getElementById("wrapper") == null) {
             try {
                 let obj = JSON.parse(original)
                 document.body.innerHTML = "<div id='wrapper'></div>"
                 var element = document.getElementById("wrapper")
                 document.jsonTree = jsonTree.create(obj, element)
                 document.jsonTree.limitedExpand(20)
             } catch(e) {
                 console.log("Error: " + e)
                 return
             }
         } else {
             document.body.innerHTML = "<div style='font: monospace;'>" + original + "</div>"
         }
     } else if (event.name == "expand") {
         document.jsonTree.expand()
     } else if (event.name == "collapse") {
         document.jsonTree.collapse()
     } else if (event.name == "expand1") {
         document.jsonTree.expandOne()
     }
});

function handleContextMenu(event) {
    safari.extension.setContextMenuEventUserInfo(event, {"json": true , "tree": document.getElementById("wrapper") !== null });
}
