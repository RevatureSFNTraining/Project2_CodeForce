({
    retrieveMID : function(component, event, helper) {
        var ProductID = component.get("v.ProductID");
        var m = component.get("c.productInfo");
        m.setParams({"product" : ProductID});
        m.setCallback(this,function(response){
            if(response.getState == "SUCCESS"){
                var MID = response.getReturnValue();
                component.set("v.manufacturerID",MID);
            }
        });
        $A.enqueueAction(m);
    }
})
