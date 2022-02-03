trigger FeaturedM on Featured_Account__c (before delete) {

    switch on Trigger.OperationType {
        when BEFORE_DELETE {
        FeaturedMTriggerHelper.FeaturedMTriggerHelper(trigger.old);
        }
    }
}