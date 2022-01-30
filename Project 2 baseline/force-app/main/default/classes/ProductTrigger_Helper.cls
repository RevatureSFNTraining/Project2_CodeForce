public class ProductTrigger_Helper {
    
	//method for trigger
    public static void discontinued(List<Product2> pList){
        //creating lists to be used later
        List<String> itemList = new List<String>();
        List<Messaging.SingleEmailMessage> mailList =  new List<Messaging.SingleEmailMessage>();
    	List<String> sendTo = new List<String>();
        //iterate through list of updated products to find any not marked as active
        for (Product2 p: pList) {
            if (p.isActive == false) {
                itemList.add(p.Name);
            }
        }
        
        //this query took some work! We need to find orders containing the above list of products that have not yet been processed
        //then we need to find the email address of any account with the unprocessed order
        for (OrderItem oi : [SELECT Product2.Name, Order.Status, Order.Account.Email__c From OrderItem WHERE Product2.Name IN :itemList]){
            // we will only notify accounts if their order has not yet been processed
            If (oi.Order.Status == 'Received'){
                //we then create a message with the product name and send it to the affected account
                Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                sendTo.add(oi.Order.Account.Email__c);
                mail.setToAddresses(sendTo);
                mail.setReplyTo('nnassib336@gmail.com');
      			mail.setSenderDisplayName('Dropforce Customer Relations');
                mail.setSubject('Product Discontinued');
              
                String body = oi.Product2.name + ' has been discontinued. You will receive a full refund within 3 business days. We apologize for any inconvenience.';
                mail.setHtmlBody(body);
                //adding the message to a list of messaged to be sent
                mailList.add(mail);
            }
        }
        
        //if any messages have been added to the list, they are all sent at once. the if statement was required for the negative test to work properly
        If (mailList.size() > 0){
     	Messaging.sendEmail(mailList);
        }
    }
}