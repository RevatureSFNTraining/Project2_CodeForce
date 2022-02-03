trigger PreventDuplicateAccountTrigger on Account (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHelper.handleAccount(Trigger.new); 
    }  
}