@isTest
public with sharing class SetOrderTypeTrigger_Helper_Test {
    //This Method Tests for both Positive, & Negative Bulk situations
    @isTest(SeeAllData=true)
    public static void bulkOrderTestCase(){
        Integer expected = 5;
        Integer Success = 0;
        Integer Fail=0;
        List<order> ord = new list<order>();
        ord = [SELECT id, TotalAmount, type FROM Order limit 5 ];
        for(Order o : ord) {
            o.Name='Test';
            update o;
            if(o.TotalAmount>=10000 && o.Type=='Bulk'){
                Success+=1;
                system.debug('Success bulk');
            }else if(o.TotalAmount<10000 && o.Type=='Small'){
                Success+=1;
                system.debug('Success small');
        	}
        }
        system.assertEquals(expected, Success);
    }
    
    @isTest(SeeAllData=true)
    public static void singlesmallTestCase(){
        Integer Success=0;
        order ord = [SELECT id, TotalAmount, type FROM Order where totalAmount<10000 limit 1];
        if(ord.TotalAmount<10000 && ord.Type=='Small'){
                Success+=1;
                system.debug('Success small');
        	}
        system.assertEquals(1, Success);
    }
    @isTest(SeeAllData=true)
    public static void singlebulkTestCase(){
        Integer Success=0;
        order ord = [SELECT id, TotalAmount, type FROM Order where totalAmount>=10000 limit 1];
        if(ord.TotalAmount>10000 && ord.Type=='Bulk'){
                Success+=1;
                system.debug('Success Bulk');
        	}
        system.assertEquals(1, Success);
	}
}
