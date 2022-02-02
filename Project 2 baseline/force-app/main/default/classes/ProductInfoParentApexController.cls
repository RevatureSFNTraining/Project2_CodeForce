public without sharing class ProductInfoParentApexController {
    public ProductInfoParentApexController() {

    }

    @AuraEnabled
    public static String productInfo(String product){
        //retrieving manufacturer ID using the product ID
        String i;
        Product2 prod = [SELECT ID, Drop_Force__Manufacturer__c, Name FROM Product2 WHERE ID= '01t8c00000HDzmsAAD' LIMIT 1];
        i = prod.Drop_Force__Manufacturer__c;
        system.debug(i);
        return i;
    }
}