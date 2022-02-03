({
    falsey:function(component) {

        if (component.get("v.truthy") == "false") {
            component.set("v.truthy", "true");
        } else if (component.get("v.truthy") == "true") {
            component.set("v.truthy", "truthy")
        } else if (component.get("v.truthy") == "truthy") {
            component.set("v.truthy", "true");
        }
            
    }

})