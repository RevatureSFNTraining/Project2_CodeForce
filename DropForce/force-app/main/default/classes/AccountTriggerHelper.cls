public with sharing class AccountTriggerHelper {
    public static void handleAccount(List<Account> newList){
        //prepare Account names and phone numbers in a set
        Set<String> nameSet = new Set<String>();
        Set<String> phoneSet = new Set<String>();
        
        for(Account acc: newList){
            nameSet.add(acc.Name);
            phoneSet.add(acc.Phone); 
        }
        
        //get the list of accounts from database that match name and phone number in our set
        
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE Name in:nameSet OR Phone in:phoneSet]);
        
        //check to see - if there are any accounts in the list, display an error message.
        for(Account acc: newList){
            if(accList.size() > 0){
                acc.addError('Account with the same name or phone number already exists. Duplicate Accounts cannot be created.');
            }
        }
    }
}
