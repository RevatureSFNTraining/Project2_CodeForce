@isTest
public class objectRenderListControllerTest {

    /* Written by: Anna Sersch
       Test Class for the Aura Controller objectRenderListController
        */

    @TestSetup
    static void makeData(){
        Drop_Force__Featured_Account__c nAcc = new Drop_Force__Featured_Account__c();
        insert nAcc;
        Drop_Force__Featured_Product__c nProd = new Drop_Force__Featured_Product__c();
        insert nProd;

        Drop_Force__Featured_Account__c lookupA = [SELECT Id FROM Drop_Force__Featured_Account__c LIMIT 1];
        Id lookupId = lookupA.Id;

        
        // create 6 Manufacturer accounts, create 1 featured object, link 3 accounts to the featured object 
        List<Account> testAccts = new List<Account>();

        for(Integer x=0;x<=4;x++) {
            testAccts.add(new Account(Name = 'Test Account', Type = 'Manufacturer', Drop_Force__FeaturedM__c = lookupId));
        }
        
        insert testAccts;

        Drop_Force__Featured_Product__c lookupP = [SELECT Id FROM Drop_Force__Featured_Product__c LIMIT 1];
        Account accountID = [Select Id FROM Account LIMIT 1];
        lookupId = lookupP.Id;
        Id accId = accountID.Id;

        List<Product2> testProd = new List<Product2>();

        for(Integer x=0;x<=4;x++) {
            testProd.add(new Product2(Name = 'Test Prod', Drop_Force__Product__c = lookupId, Drop_Force__Manufacturer__c = accId, Drop_Force__Price__c = 1));
        }

        insert testProd;

    }

    @isTest
    public static void FProductTest() {
        
        Test.startTest();
        List<sObject> result = objectRenderListController.fetchObj('FProduct', 3, '0', 'none');
        Test.stopTest();

        Schema.SObjectType expected = Schema.Product2.getSObjectType();
        System.assertEquals(expected, result[0].getSObjectType());

    }
    
    @isTest
    public static void FSupplierTest() {
        
        Test.startTest();
        List<sObject> result = objectRenderListController.fetchObj('FSupplier', 3, '0', 'none');
        Test.stopTest();

        Schema.SObjectType expected = Schema.Account.getSObjectType();
        System.assertEquals(expected, result[0].getSObjectType());

    } 
    
    @isTest
    public static void SearchTest() {
        
        Test.startTest();
        List<sObject> result = objectRenderListController.fetchObj('Search', 3, '0', 'Test');
        Test.stopTest();

        Schema.SObjectType expected = Schema.Product2.getSObjectType();
        System.assertEquals(expected, result[0].getSObjectType());

    }
    
    @isTest
    public static void ProductTest() {
        Account accountID = [Select Id FROM Account LIMIT 1];
        String accId = String.valueOf(accountID.Id);


        Test.startTest();
        List<sObject> result = objectRenderListController.fetchObj('Product', 3, accId, 'none');
        Test.stopTest();

        Schema.SObjectType expected = Schema.Product2.getSObjectType();
        System.assertEquals(expected, result[0].getSObjectType());

    }

    @isTest
    public static void NegativeInputTest() {
        
        Test.startTest();
        List<sObject> result = objectRenderListController.fetchObj('misc', 3, '0', 'none');
        Test.stopTest();

        Schema.SObjectType expected = Schema.Account.getSObjectType();
        System.assertEquals(expected, result[0].getSObjectType());

    } 


}