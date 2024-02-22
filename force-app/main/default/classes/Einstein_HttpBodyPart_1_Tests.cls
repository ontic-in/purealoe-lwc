
@isTest
private class Einstein_HttpBodyPart_1_Tests {

    // Since the getBoundary method doesn't interact with any Salesforce records, we do not need a @testSetup method for creating test data.

    // This test case checks whether the getBoundary method returns the correct boundary
    @isTest
    static void testGetBoundary() {
        // Expected boundary string from the Einstein_HttpBodyPart class
        String expectedBoundary = '1ff13444ed8140c7a32fc4e6451aa76d';

        // Call the method
        String boundary = Einstein_HttpBodyPart.getBoundary();

        // Perform assertions
        System.assertEquals(expectedBoundary, boundary, 'The boundary should match the expected value.');

        // Assert the boundary is the correct length
        System.assertEquals(32, boundary.length(), 'The boundary should be 32 characters long.');
    }
}
