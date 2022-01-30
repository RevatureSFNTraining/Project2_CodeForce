@isTest
public class FeaturedMTesting {
    @TestSetup
    static void makeData(){
        Featured_Account__c nAcc = new Featured_Account__c();
        insert nAcc;

        Featured_Account__c lookup = [SELECT Id FROM Featured_Account__c LIMIT 1];

        Id lookupId = lookup.Id;

        // create 6 Manufacturer accounts, create 1 featured object, link 3 accounts to the featured object 
        List<Account> testAccts = new List<Account>();

        for(Integer x=0;x<=2;x++) {
            testAccts.add(new Account(Name = 'Test Account', Type = 'Manufacturer', FeaturedM__c = lookupId));
        }

        for(Integer x=0;x<=2;x++) {
            testAccts.add(new Account(Name = 'Test Account', Type = 'Manufacturer'));
        }
        
        insert testAccts;

    }

    @isTest
    public static void positiveTest() {
        /* checks if the accounts are updated correctly by checking if deletion went through and count number of look up relationships in account  */
        
        Featured_Account__c positiveTest = [SELECT Id FROM Featured_Account__c LIMIT 1];
        Test.startTest();
        Database.DeleteResult result = Database.delete(positiveTest, true);

        Integer x = [SELECT Count() FROM Account WHERE FeaturedM__c != Null]; // returns the number of Accounts with a Relationship to Featured_Account__c
        Integer y = [SELECT Count() FROM Featured_Account__c];
        Test.stopTest();

        System.assert(result.isSuccess()); //checks if deletion went through
        System.assertEquals(1, y);
        System.assertEquals(3, x);

    }

    @isTest
    public static void negativeTest() { //prevents delete if not enough accounts are there to replace them - we create 1 more account with a lookup to the featuredObject, so there's 4 to 3
    
        Featured_Account__c positiveTest = [SELECT Id FROM Featured_Account__c LIMIT 1];

        Account nAcc = new Account();
        nAcc.Name = 'James';
        nAcc.Type = 'Manufacturer';
        nAcc.FeaturedM__c = positiveTest.Id;

        insert nAcc;

        Test.startTest();
        Database.DeleteResult result = Database.delete(positiveTest, false);
        Test.stopTest();

        System.assert(!result.isSuccess()); //checks if deletion did not go through

      }

      // could test very large number of accounts to check for CPU exception ... however... might be unnecessary since the random thing is just until there's a better way to categorize 
}