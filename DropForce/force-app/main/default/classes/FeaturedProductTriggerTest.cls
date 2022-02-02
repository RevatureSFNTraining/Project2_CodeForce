@isTest
public class FeaturedProductTriggerTest {
	
    @testSetup
    public static void generateTestData() {
        // Create a Featured Product record
        Featured_Product__c testFeatured = new Featured_Product__c();
        insert testFeatured;
        Featured_Product__c testId = [SELECT Id FROM Featured_Product__c LIMIT 1];
        // Create Manufacturer Account for Product Required Field
        Account testManufacturer = new Account(Name='Mr Test', Type = 'Manufacturer');
        insert testManufacturer;
        Account manufacturerId = [SELECT Id FROM Account WHERE Type='Manufacturer' LIMIT 1];
        // Generate 6 Products
        List<Product2> testProductList = new List<Product2>();
        for (Integer i = 0; i < 6; i++) {
            String n = 'Product '+ i;
            testProductList.add(new Product2(Name=n, Manufacturer__c = manufacturerId.Id, Price__c = 15));
        }
        insert testProductList;
        // Assign 3 of them to the Featured List
        List<Product2> featuredIdSet = [SELECT Id, Product__c FROM Product2 LIMIT 3];
        for (Product2 p : featuredIdSet) {
            p.Product__c = testId.Id;
        }
        update featuredIdSet;
    }
    
    @isTest
    public static void checkFeaturedListNew() {
        // Query the test Featured List
        Featured_Product__c testDeletion = [SELECT Id FROM Featured_Product__c LIMIT 1];
		// Save the Id of Current List
		Id oldId = testDeletion.Id;
		// Run Deletion
        try {
            delete testDeletion;
        }catch (Exception e) {
            System.Debug('Deletion Failed');
        }
		// Query the new Featured List
		Featured_Product__c checkNew = [SELECT Id FROM Featured_Product__c LIMIT 1];
		// Ensure Id does not match old record
		System.assert(checkNew.Id != oldId);
    }
    
    @isTest
    public static void checkDeletionPrevented() {
        // Query the test Featured List
        Featured_Product__c testDeletion = [SELECT Id FROM Featured_Product__c LIMIT 1];
		// Save the Id of Current List
		Id oldId = testDeletion.Id;
        // Remove a Product from Test data
		// Use Case : Not Enough Products for Completely New List
        Product2 removeForTest = [SELECT Id FROM Product2 WHERE Product__c != :oldId LIMIT 1];
        delete removeForTest;
        // Run Deletion
        try {
            delete testDeletion;
        }catch (Exception e) {
            System.Debug('Deletion Prevented');
        }
		// Query the Old Featured List
		Featured_Product__c checkIsOld = [SELECT Id FROM Featured_Product__c LIMIT 1];
		// Ensure Id does match old record
		System.assert(checkIsOld.Id == oldId);
    }
}