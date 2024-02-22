
@isTest
private class MerchandiseController_3_Tests {

    @TestSetup
    static void setupTestData() {
        // Creating test data for Merchandise__c without setting the Name field
        List<Merchandise__c> merchandiseList = new List<Merchandise__c>();
        for (Integer i = 0; i < 5; i++) {
            merchandiseList.add(new Merchandise__c(
                // Assuming Title__c can be used as an identifier for test purposes
                Title__c = 'TestTitle' + i,
                Description__c = 'TestDescription' + i,
                Price__c = 100.00 + i,
                Category__c = 'TestCategory',
                Picture_URL__c = 'http://example.com/picture' + i + '.jpg'
            ));
        }
        insert merchandiseList;
    }

    // Test for the happy path when merchandise data is available
    @isTest
    static void testGetAllMerchandiseWithData() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Test.startTest();
        List<Merchandise__c> merchandise = MerchandiseController.getAllMerchandise();
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, merchandise, 'The merchandise list should not be null.');
        System.assertEquals(5, merchandise.size(), 'The merchandise list should have 5 items.');
    }

    // Test for the sad path when there is no merchandise data
    @isTest
    static void testGetAllMerchandiseWithNoData() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Delete test data to simulate no merchandise data available
        delete [SELECT Id FROM Merchandise__c];

        Test.startTest();
        List<Merchandise__c> merchandise = MerchandiseController.getAllMerchandise();
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, merchandise, 'The merchandise list should not be null.');
        System.assertEquals(0, merchandise.size(), 'The merchandise list should be empty.');
    }
}
