//I know this should be avoided if possible, but I needed to work with several objects that required a lookup relationship and felt it would
//be easier to just create some test records
@isTest(SeeAllData=true)
public class ProductTrigger_Helper_Test {

    //positive single test
    @isTest
    public static void positiveSingleTest(){
        Test.startTest();
        //pulling the test record from the org, setting isActive to false, then updating it which runs the trigger
        Product2 prod = [SELECT isActive FROM Product2 Where name='For trigger testing'];
        prod.isActive = false;
        update prod;
		Integer emails = Limits.getEmailInvocations();
        Test.stopTest();
        //verifying that an email was sent
        system.assertEquals(1, emails);
    }
    
    //negative single test
    @isTest
    public static void negativeSingleTest(){
        Test.startTest();
        //pulling the test record from the org, setting isActive to true, then updating it which runs the trigger
        Product2 prod = [SELECT isActive FROM Product2 Where name='For trigger testing'];
        prod.isActive = true;
        update prod;
        Integer emails = Limits.getEmailInvocations();
        Test.stopTest();
        //verifying that no email was sent
        system.assertEquals(0, emails);
    }
    
    //restricted user test
    @isTest
    public static void testRunAs() {
        // Setup test data
        // Create a unique UserName
        String uniqueUserName = 'testuser' + DateTime.now().getTime() + '@test.com';
        // Create user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
		User u = new User(Alias = 'testUser', Email='testuser@test.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Chicago',
         UserName=uniqueUserName);
        
        //attempting to update the isActive field on our product
        System.runAs(u){
            try{
                Product2 prod = [SELECT isActive FROM Product2 Where name='For trigger testing'];
        		prod.isActive = false;
        		update prod;
            }
            //we expect an exception so we need to catch it
            catch (Exception e){
                system.debug('Error was caught');
            }
        }
    }
}