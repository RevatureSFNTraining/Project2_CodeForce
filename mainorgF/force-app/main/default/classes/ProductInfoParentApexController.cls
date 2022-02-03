//Written by Nathan. This controller links to ProductInfoParent.cmp 
public without sharing class ProductInfoParentApexController {
    public ProductInfoParentApexController() {

    }
    
    @AuraEnabled
    public static String productInfo(String product){
        //retrieving manufacturer ID using the product ID
        String i;
        Product2 prod = [SELECT Drop_Force__Manufacturer__c, Name FROM Product2 WHERE ID= :product LIMIT 1];
        i = prod.Drop_Force__Manufacturer__c;
        system.debug(i);
        return i;
    }
}