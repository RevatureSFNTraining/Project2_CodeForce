({   
    fetchObjects : function(component, event, helper) {
        var action = component.get("c.fetchObj");

        action.setParams({input : component.get("v.typeObject"), limitV : component.get("v.hMany"), mId : component.get("v.manufacturerID"), pSearch : component.get("v.searchProduct")});

        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.objectList", response.getReturnValue());
            }
        });

        $A.enqueueAction(action);
    }
})