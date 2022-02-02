public class objectRenderListController {

    @AuraEnabled
    public static List<sObject> fetchObj (String input, Integer limitV, Id manuId){

        if (input == 'FSupplier') {
            return [SELECT Id,PhotoUrl FROM Account WHERE FeaturedM__c != null AND Type = 'Manufacturer' LIMIT :limitV]; //featured Supplier
        } else if (input == 'FProduct') {
            return [SELECT DisplayUrl,Id FROM Product2 WHERE Product__c != null LIMIT :limitV]; // featured product
        } else if (input == 'Product') {
            return [SELECT DisplayUrl,Id FROM Product2 WHERE Manufacturer__c = :manuId LIMIT :limitV]; 
        } else {
            return [SELECT Id,PhotoUrl FROM Account WHERE FeaturedM__c != null AND Type = 'Manufacturer' LIMIT :limitV];
        }
    }

}