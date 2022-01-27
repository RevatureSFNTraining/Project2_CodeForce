trigger FeaturedM on Featured_Account__c (before delete) {

    Id featuredMobject = trigger.old[0].id;

    List<Account> previousFeature = [SELECT FeaturedM__c,Id FROM Account WHERE Type = 'Manufacturer' AND FeaturedM__c = :featuredMobject];
    List<Account> newFeature = [SELECT FeaturedM__c,Id FROM Account WHERE Type = 'Manufacturer' AND Id NOT IN :previousFeature];
    // check if length of accounts left is larger or equals than length of previous feature, if yes continue if not addError preventing deletion

    Integer plistSize = previousFeature.size() - 1;
    Integer nlistSize = newFeature.size() - 1;

    if (plistSize+1 > nlistSize+1) {
        trigger.old[0].addError('Cannot Delete Featured Manufacturer Object because there are not enough accounts to replace it with');
    }

    set<Integer> randomNumber = new set<Integer>();

    //chooses a random number from the remaining accounts and assigns them to the list

    while (randomNumber.size() <= plistSize) {
        randomNumber.add(Integer.valueof(Math.random() * nlistSize));    
    }

    system.debug(randomNumber);

    //creates a look up relationship between the accounts to be featured and the .. oh i must create a new featuredMobject first. So create new featuredM object, soql query it, assign that id

    for (Integer i : randomNumber) {
        newFeature[i].FeaturedM__c = featuredMobject;
    }

}