@istest
public class ProductInfoParentApexController_test {
	
    @isTest
    public static void positiveTest(){
        test.startTest();
        String testPID = '01t8c00000HDzmsAAD';
        String testMID = ProductInfoParentApexController.productInfo(testPID);
        system.assertEquals('0018c000028pDCZAA2', testMID);
        test.stopTest();
    }
}