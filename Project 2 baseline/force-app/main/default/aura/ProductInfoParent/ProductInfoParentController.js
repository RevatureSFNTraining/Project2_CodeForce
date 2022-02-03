({
	//this method receives a product ID and asks the server for the related manufacturer's ID
    retrieveMID : function(component, event, helper) {
       // var productID = component.get("v.productID");
        var m = component.get("c.productInfo");
        m.setParams({product : component.get("v.productID")});
        m.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.manuID", response.getReturnValue());
                var manuID = component.get("v.manuID");
                console.log(manuID);
            } else {
                console.log("retrieveMID failed")
            }
        });
        $A.enqueueAction(m);
    }
})