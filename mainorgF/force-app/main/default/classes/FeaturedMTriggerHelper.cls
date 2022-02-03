public class FeaturedMTriggerHelper { //Anna Sersch
    public static void FeaturedMTriggerHelper(List<Drop_Force__Featured_Account__c> fmList) {
        Id featuredMobject = fmList[0].id;

        List<Account> previousFeature = [SELECT Drop_Force__FeaturedM__c,Id FROM Account WHERE Type = 'Manufacturer' AND Drop_Force__FeaturedM__c = :featuredMobject];
        List<Account> newFeature = [SELECT Drop_Force__FeaturedM__c,Id FROM Account WHERE Type = 'Manufacturer' AND Id NOT IN :previousFeature];

    
        Integer plistSize = previousFeature.size();
        Integer nlistSize = newFeature.size();
        
        if (plistSize > 0) {
            if (plistSize > nlistSize) {
                fmList[0].addError('Cannot Delete Featured Manufacturer Object because there are not enough accounts to replace it with');
            }
            else {
                set<Integer> randomNumber = new set<Integer>();
                
                //chooses a random number from the remaining accounts and assigns them to the set - this makes sure all numbers are unique


                
                while (randomNumber.size() < plistSize) {
                    randomNumber.add(Integer.valueof(Math.random() * nlistSize));    
                }

                Drop_Force__Featured_Account__c nAcc = new Drop_Force__Featured_Account__c();
                insert nAcc;

                Drop_Force__Featured_Account__c newFM = [Select Id FROM Drop_Force__Featured_Account__c WHERE Id != :featuredMobject LIMIT 1];

                
                //creates a look up relationship between the accounts to be featured and the .. oh i must create a new featuredMobject first. So create new featuredM object, soql query it, assign that id
                List<Account> updateAcc = new List<Account>();

                for (Integer i : randomNumber) {
                    newFeature[i].Drop_Force__FeaturedM__c = newFM.Id;
                    updateAcc.add(newFeature[i]);
                }

                update updateAcc;
            }
        }
    }
}