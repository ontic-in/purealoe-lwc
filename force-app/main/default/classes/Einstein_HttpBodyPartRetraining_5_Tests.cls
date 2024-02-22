
@isTest
private class Einstein_HttpBodyPartRetraining_5_Tests {

    @isTest
    static void testSetEpochsPositiveValue() {
        Einstein_HttpBodyPartRetraining retraining = new Einstein_HttpBodyPartRetraining('modelId', 1, 0.0001, null);
        retraining.setEpochs(50);
        
        System.assertEquals(50, retraining.getEpochs(), 'The epochs should be set to 50');
    }
    
    @isTest
    static void testSetEpochsNullValue() {
        Einstein_HttpBodyPartRetraining retraining = new Einstein_HttpBodyPartRetraining('modelId', 1, 0.0001, null);
        retraining.setEpochs(null);
        
        System.assertEquals(null, retraining.getEpochs(), 'The epochs should be set to null');
    }
    
    @isTest
    static void testSetEpochsZeroValue() {
        Einstein_HttpBodyPartRetraining retraining = new Einstein_HttpBodyPartRetraining('modelId', 1, 0.0001, null);
        retraining.setEpochs(0);
        
        System.assertEquals(null, retraining.getEpochs(), 'The epochs should be set to null when setEpochs is passed a zero value');
    }

    @isTest
    static void testSetEpochsGreaterThanMaxValue() {
        Einstein_HttpBodyPartRetraining retraining = new Einstein_HttpBodyPartRetraining('modelId', 1, 0.0001, null);
        Boolean isExceptionThrown = false;
        try {
            retraining.setEpochs(101);
        } catch (Einstein_NumberTooBigException e) {
            isExceptionThrown = true;
            String expectedMessage = 'The maximum allowed size for "epochs" is 100 (current: 101).';
            System.assertEquals(expectedMessage, e.getMessage(), 'Exception message mismatch');
        }
        
        System.assert(isExceptionThrown, 'An Einstein_NumberTooBigException should have been thrown for epochs greater than 100');
    }
}
