trigger FeaturedProductTrigger on Featured_Product__c (before delete) {

    if (Trigger.isBefore && Trigger.isDelete) {
        FeaturedProductTriggerHelper.handleTrigger(Trigger.old);
    }
    
}