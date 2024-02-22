
@isTest
private class Einstein_HttpBodyPartRetraining_4_Tests {

    // Helper method to create a valid Einstein_HttpBodyPartRetraining instance
    private static Einstein_HttpBodyPartRetraining createValidInstance() {
        return new Einstein_HttpBodyPartRetraining('someModelId', 50, 0.005, null);
    }
    
    @isTest
    static void testGetEpochsWithValidValue() {
        Einstein_HttpBodyPartRetraining instance = createValidInstance();
        Integer epochs = instance.getEpochs();
        System.assertEquals(50, epochs, 'The epochs should be 50');
    }
    
    @isTest
    static void testGetEpochsWithNullValue() {
        Einstein_HttpBodyPartRetraining instance = new Einstein_HttpBodyPartRetraining('someModelId', null, 0.005, null);
        Integer epochs = instance.getEpochs();
        // If epochs are set to null, hasEpochs is false, but the getEpochs method still returns the default value of epochs
        // which is expected to be null if not explicitly initialized.
        System.assertEquals(null, epochs, 'The epochs should be null since it was set to null');
    }
    
    @isTest
    static void testGetEpochsWithZeroValue() {
        Einstein_HttpBodyPartRetraining instance = new Einstein_HttpBodyPartRetraining('someModelId', 0, 0.005, null);
        Integer epochs = instance.getEpochs();
        System.assertEquals(0, epochs, 'The epochs should be zero since it was set to zero');
    }
    
    @isTest
    static void testSetEpochsAboveMaximumThrowsException() {
        Boolean didThrow = false;
        try {
            new Einstein_HttpBodyPartRetraining('someModelId', 101, 0.005, null);
        } catch (Einstein_NumberTooBigException e) {
            didThrow = true;
        }
        System.assert(didThrow, 'Setting epochs above the maximum limit should throw an Einstein_NumberTooBigException');
    }
}
