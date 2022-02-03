@isTest
public class OrderCheckHelperTest {
	
    @isTest
    public static void positiveSingleTest(){
        
        Order ord = new Order();
        Account account = new Account();
        account.Name = 'Wowzers';
        account.Type = 'Retailer';
        insert account;
        List<Account> accounts = [SELECT Id FROM Account];
        for(Account acc : accounts)
        {
            ord.AccountId = acc.id;
        }
        ord.EffectiveDate = date.ValueOf('2022-02-03');
        ord.Status = 'Received';
        
        insert ord;
        
        Test.startTest();
        ord.Status = 'Processed';
        try
        {
            update ord;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('Order cannot be canceled') ? true : false;
			System.AssertEquals(expectedExceptionThrown, true); 
        }
        Test.stopTest();
    }
    
    @isTest
    public static void negativeSingleTest(){
        
        Order ord = new Order();
        Account account = new Account();
        account.Name = 'Wowzers';
        account.Type = 'Retailer';
        insert account;
        List<Account> accounts = [SELECT Id FROM Account];
        for(Account acc : accounts)
        {
            ord.AccountId = acc.id;
        }
        ord.EffectiveDate = date.ValueOf('2022-02-03');
        ord.Status = 'Received';
        
        insert ord;
        
        Test.startTest();
        ord.Status = 'Processed';
        try
        {
            update ord;
            ord.Status = 'Received';
            update ord;
            
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('Order cannot be canceled') ? true : false;
			System.AssertEquals(expectedExceptionThrown, true); 
        }
        Test.stopTest();
    }
    
    @isTest
    public static void positiveDeleteSingleTest(){
        
        Order ord = new Order();
        Account account = new Account();
        account.Name = 'Wowzers';
        account.Type = 'Retailer';
        insert account;
        List<Account> accounts = [SELECT Id FROM Account];
        for(Account acc : accounts)
        {
            ord.AccountId = acc.id;
        }
        ord.EffectiveDate = date.ValueOf('2022-02-03');
        ord.Status = 'Received';
        
        insert ord;
        
        Test.startTest();
        ord.Status = 'Processed';
        try
        {
            delete ord;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('Order cannot be canceled') ? true : false;
			System.AssertEquals(expectedExceptionThrown, false); 
        }
        Test.stopTest();
    }
    
    @isTest
    public static void negativeDeleteSingleTest(){
        
        Order ord = new Order();
        Account account = new Account();
        account.Name = 'Wowzers';
        account.Type = 'Retailer';
        insert account;
        List<Account> accounts = [SELECT Id FROM Account];
        for(Account acc : accounts)
        {
            ord.AccountId = acc.id;
        }
        ord.EffectiveDate = date.ValueOf('2022-02-03');
        ord.Status = 'Received';
        
        insert ord;
        
        Test.startTest();
        try
        {
            delete ord;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('Order cannot be canceled') ? true : false;
			System.AssertEquals(expectedExceptionThrown, false); 
        }
        Test.stopTest();
    }
}