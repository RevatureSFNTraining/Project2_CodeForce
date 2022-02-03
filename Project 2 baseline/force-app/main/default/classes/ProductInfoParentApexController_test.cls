//written by Nathan. This class tests ProductInfoParentApexController 
@istest
public class ProductInfoParentApexController_test {
    
    //setting up data for the test
    @testSetup
    public static void testData(){
        Account a = new Account (Name = 'Test Account', Type = 'Manufacturer');
        insert a;
        Account aa = [SELECT ID FROM Account WHERE Name = 'Test Account'];
        String testMID = aa.ID;
        Product2 p = new Product2 (Name = 'Test Product', Drop_Force__Manufacturer__c = testMID, Drop_Force__Price__c = 10);
        insert p;
    }
	
    //testing to see if it works
    @isTest
    public static void positiveTest(){
        test.startTest();
        //retrieving account ID
        Account aa = [SELECT ID FROM Account WHERE Name = 'Test Account'];
        String a = aa.ID;
        //retrieving product ID
        Product2 p = [SELECT ID FROM Product2 WHERE Name = 'Test Product'];
        String testPID = p.ID;
        //sending product ID and returning account ID
        String testMID = ProductInfoParentApexController.productInfo(testPID);
        //checking to see if IDs match
        system.assertEquals(a, testMID);
        test.stopTest();
    }
}