
@isTest
private class MerchandiseController_2_Tests {

    @testSetup
    static void setup() {
        // Create test data for Merchandise__c records
        List<Merchandise__c> merchandiseList = new List<Merchandise__c>();
        merchandiseList.add(new Merchandise__c(
            Category__c = 'Apparel',
            Price__c = 20.0
        ));
        merchandiseList.add(new Merchandise__c(
            Category__c = 'Accessories',
            Price__c = 10.0
        ));

        // Insert the test data
        insert merchandiseList;
    }

    @isTest
    static void testGetMerchandiseWithValidFilters() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Prepare valid filters, pageSize, and pageNumber
        MerchandiseController.Filter filterObj = new MerchandiseController.Filter();
        filterObj.searchKey = ''; // Assume search key is optional
        filterObj.category = 'Apparel';
        filterObj.minPrice = 15.0;
        filterObj.maxPrice = 25.0;
        String filters = JSON.serialize(filterObj);
        Decimal pageSize = 10;
        Decimal pageNumber = 1;

        // Call the method and perform assertions
        Test.startTest();
        MerchandiseController.PagedResult result = MerchandiseController.getMerchandise(filters, pageSize, pageNumber);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(1, result.items.size(), 'Should return 1 merchandise item.');
    }

    @isTest
    static void testGetMerchandiseWithMalformedFilters() {
        // Prepare invalid (malformed) JSON string for filters
        String filters = 'invalid JSON';
        Decimal pageSize = 10;
        Decimal pageNumber = 1;

        // Test exception handling
        Boolean exceptionThrown = false;
        try {
            MerchandiseController.getMerchandise(filters, pageSize, pageNumber);
        } catch (Exception e) {
            exceptionThrown = true;
        }

        // Assertions
        System.assertEquals(true, exceptionThrown, 'An exception should have been thrown due to malformed JSON filters.');
    }
    
    // Additional test methods for other scenarios can be written following similar patterns.
}
