public with sharing class TestLWC {

    @AuraEnabled(cacheable=true)
    public static Product2 getProduct(){
        Product2 prod = [SELECT Id, Name, Description, Product_URL__c, Price__c FROM Product2 WHERE Name = 'Gaming Desktop PC'];
        return prod;
    }
}