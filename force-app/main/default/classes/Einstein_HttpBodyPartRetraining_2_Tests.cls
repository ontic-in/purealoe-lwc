
@isTest
private class Einstein_HttpBodyPartRetraining_2_Tests {
    
    // Since getModelId() is not dependent on Salesforce data, we do not need @testSetup
    
    @isTest
    static void testGetModelIdReturnsCorrectModelId() {
        // Given
        String expectedModelId = 'testModelId';
        Einstein_HttpBodyPartRetraining retrainingPart = new Einstein_HttpBodyPartRetraining(
            expectedModelId, 10, 0.001, null);
        
        // When
        String actualModelId = retrainingPart.getModelId();
        
        // Then
        System.assertEquals(expectedModelId, actualModelId, 'The modelId should be the same as set in constructor');
    }
    
    @isTest
    static void testConstructorThrowsExceptionForEmptyModelId() {
        // Given
        String emptyModelId = '';
        
        // When
        Boolean exceptionThrown = false;
        try {
            Einstein_HttpBodyPartRetraining retrainingPart = new Einstein_HttpBodyPartRetraining(
                emptyModelId, 10, 0.001, null);
        } catch (Einstein_StringIsEmptyException e) {
            exceptionThrown = true;
        }
        
        // Then
        System.assert(exceptionThrown, 'An exception should have been thrown for an empty modelId');
    }
    
    @isTest
    static void testConstructorThrowsExceptionForNullModelId() {
        // Given
        String nullModelId = null;
        
        // When
        Boolean exceptionThrown = false;
        try {
            Einstein_HttpBodyPartRetraining retrainingPart = new Einstein_HttpBodyPartRetraining(
                nullModelId, 10, 0.001, null);
        } catch (Einstein_StringIsEmptyException e) {
            exceptionThrown = true;
        }
        
        // Then
        System.assert(exceptionThrown, 'An exception should have been thrown for a null modelId');
    }
}
