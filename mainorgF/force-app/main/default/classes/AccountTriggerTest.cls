@isTest
public class AccountTriggerTest {
    @testSetup 
    static void setupMethod(){
        Account acc = new Account(); 
        acc.Name = 'Dickenson plc';
        acc.Phone = '(785) 241-6200'; 
        insert acc; 
    }
    
    @isTest 
    static void createDuplicateAccount(){
        Account acc = new Account(); 
        acc.Name = 'Dickenson plc';
        acc.Phone = '(785) 241-6200';
        
        Database.saveResult save = Database.insert(acc, false);
        system.assert(!save.isSuccess());   
    }
    
    @isTest 
    static void createNewAccount(){
        Account acc = new Account(); 
        acc.Name = 'Mo Inc';
        acc.Phone = '(228) 241-6200';
        
        Database.saveResult save = Database.insert(acc, false);
        system.assert(save.isSuccess());     
    }
    
}