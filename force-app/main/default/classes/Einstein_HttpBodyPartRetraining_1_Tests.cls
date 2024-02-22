
@isTest
private class Einstein_HttpBodyPartRetraining_1_Tests {

    // Test setup is not required since we're not using any Salesforce data

    @isTest
    static void testBuildWithValidParameters() {
        Einstein_HttpBodyPartRetraining instance = new Einstein_HttpBodyPartRetraining(
            'validModelId', 
            10, 
            0.005, 
            new Einstein_TrainParams()
        );
        Blob result = instance.build();
        
        System.assertNotEquals(null, result, 'The result should not be null');
        // The instanceof check is removed since the result is always a Blob
    }

    @isTest
    static void testBuildWithEmptyModelId() {
        try {
            Einstein_HttpBodyPartRetraining instance = new Einstein_HttpBodyPartRetraining(
                '', 
                10, 
                0.005, 
                new Einstein_TrainParams()
            );
            instance.build();
            System.assert(false, 'Expected an Einstein_StringIsEmptyException to be thrown');
        } catch (Einstein_StringIsEmptyException e) {
            System.assertEquals('modelId', e.getMessage(), 'Exception message should match expected message');
        }
    }

    @isTest
    static void testBuildWithInvalidEpochs() {
        try {
            Einstein_HttpBodyPartRetraining instance = new Einstein_HttpBodyPartRetraining(
                'validModelId', 
                101, 
                0.005, 
                new Einstein_TrainParams()
            );
            instance.build();
            System.assert(false, 'Expected an Einstein_NumberTooBigException to be thrown');
        } catch (Einstein_NumberTooBigException e) {
            System.assert(e.getMessage().contains('epochs'), 'Exception message should contain "epochs"');
        }
    }

    @isTest
    static void testBuildWithInvalidLearningRate() {
        Decimal invalidRate = 0.02; // Greater than MAX_LEARNING_RAGE
        try {
            Einstein_HttpBodyPartRetraining instance = new Einstein_HttpBodyPartRetraining(
                'validModelId', 
                10, 
                invalidRate, 
                new Einstein_TrainParams()
            );
            instance.build();
            System.assert(false, 'Expected an Einstein_NumberTooBigException to be thrown');
        } catch (Einstein_NumberTooBigException e) {
            System.assert(e.getMessage().contains('learningRate'), 'Exception message should contain "learningRate"');
        }
    }

    // Additional test methods for other scenarios can be added here
}
