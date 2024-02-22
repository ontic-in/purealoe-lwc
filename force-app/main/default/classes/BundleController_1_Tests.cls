
@isTest
private class BundleController_1_Tests {
    @testSetup
    static void setup() {
        // Create test Merchandise__c record
        Merchandise__c m = new Merchandise__c(
            Title__c = 'TestTitle',
            Price__c = 100.00,
            Category__c = 'TestCategory',
            Picture_URL__c = 'http://example.com'
        );
        insert m;

        // Create test Bundle__c record
        Bundle__c b = new Bundle__c();
        insert b;

        // Create test Bundle_Item__c record related to Merchandise__c and Bundle__c
        Bundle_Item__c bi = new Bundle_Item__c(
            Merchandise__c = m.Id,
            Bundle__c = b.Id,
            Qty__c = 10
        );
        insert bi;
    }
    
    @isTest
    static void testGetBundleItemsWithValidBundleId() {
        // Bypass triggers for account, if necessary
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Retrieve the test bundle ID from the test data
        Bundle__c b = [SELECT Id FROM Bundle__c LIMIT 1];

        Test.startTest();
        // Call the method being tested
        List<Bundle_Item__c> items = BundleController.getBundleItems(b.Id);
        Test.stopTest();

        // Assert the retrieved items list is not empty
        System.assertNotEquals(null, items, 'Items list should not be null');
        // Assert that the size of the items list is as expected
        System.assertEquals(1, items.size(), 'Expected one item related to the bundle');
    }
    
    @isTest
    static void testGetBundleItemsWithNoRelatedItems() {
        // Bypass triggers for account, if necessary
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Create a dummy ID that's guaranteed not to be related to any Bundle_Item__c records
        Id dummyId = Schema.SObjectType.Bundle__c.getKeyPrefix() + '123456789012345';

        Test.startTest();
        // Call the method being tested with a dummy ID
        List<Bundle_Item__c> items = BundleController.getBundleItems(dummyId);
        Test.stopTest();

        // Assert the retrieved items list is empty
        System.assert(items.isEmpty(), 'Items list should be empty');
    }
    
    @isTest
    static void testGetBundleItemsWithNullId() {
        // Bypass triggers for account, if necessary
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Test.startTest();
        // Call the method being tested with a null ID
        List<Bundle_Item__c> items = BundleController.getBundleItems(null);
        Test.stopTest();

        // Assert the retrieved items list is empty
        System.assert(items.isEmpty(), 'Items list should be empty when called with null ID');
    }
}
