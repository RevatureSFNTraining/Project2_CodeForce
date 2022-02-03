public class objectRenderListController { 
    
    /*Written by: Anna Sersch
      Description: Takes in 4 inputs. 
      
      Input: Determines what Type of Object they are Querying
      limitV: how many Objects they want returned
      mId: if you are querying for Products related to a Manufacturer this needs to be provided.
      pSearch: search term being queried if doing a product search by name 
      
      This is the Apex Controller for the Aura Component "TakesObjectReturnsImageList" also written by Anna Sersch */

    @AuraEnabled
    public static List<sObject> fetchObj (String input, Integer limitV, String mId, String pSearch){

        if (input == 'FSupplier') {
            
            return [SELECT Drop_Force__DisplayURL__c,Id FROM Account WHERE Drop_Force__FeaturedM__c != null AND Type = 'Manufacturer' LIMIT :limitV]; //featured Supplier
            
        } else if (input == 'FProduct') {
            
            return [SELECT Drop_Force__DisplayURL__c,Id FROM Product2 WHERE Drop_Force__Product__c != null LIMIT :limitV]; // featured product
            
        } else if (input == 'Product') {
            String manufacID = mId;
            return [SELECT Drop_Force__DisplayURL__c,Id FROM Product2 WHERE Drop_Force__Manufacturer__c = :manufacID LIMIT :limitV];

        } else if (input == 'Search') {
            String searchString = '%' + pSearch + '%';
            return [SELECT Drop_Force__DisplayURL__c,Id,Name FROM Product2 WHERE Name LIKE :searchString LIMIT :limitV];

        } else {
            return [SELECT Id,Drop_Force__DisplayURL__c FROM Account WHERE Drop_Force__FeaturedM__c != null AND Type = 'Manufacturer' LIMIT :limitV];

        }
    }

}