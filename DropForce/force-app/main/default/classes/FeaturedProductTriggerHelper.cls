public class FeaturedProductTriggerHelper {

    public static void handleTrigger(List<Featured_Product__c> fpList) {
        // Gather list of Products on the Featured List being removed
        List<Product2> previous = [SELECT Id, Product__c FROM Product2 WHERE Product__c = :fpList[0].Id];
        // Gather list of Products NOT on the Featured List being removed
        List<Product2> next = [SELECT Id, Product__c FROM Product2 WHERE Product__c != :fpList[0].Id];
        // Ensure that there are enough new Products for the Next Featured List
        if (next.size() < previous.size()) {
			fpList[0].addError('Not Enough Different Products for Next Featured List');
        }
        else {
            // Generate a random Selection of Products for the New Featured List
        	set<Integer> randNum = new set<Integer>();
        	while(randNum.size() < previous.size()) {
            	randNum.add( Integer.valueof( Math.random()*next.size() ) );
        	}
        	// Generate a new Record to hold the new Featured List
        	Featured_Product__c newFpList = new Featured_Product__c();
        	insert newFpList;        
        	Featured_Product__c newListId = [SELECT Id FROM Featured_Product__c WHERE Id != :fpList[0].Id LIMIT 1];
        	// Set the Random Products to be on the newly created Featured List
        	List<Product2> updateList = new List<Product2>();
            for (Integer i : randNum) {
            	next[i].Product__c = newListId.Id;
                updateList.add(next[i]);
        	}
        	update updateList;
        }
    }
    
}