
@isTest
private class Einstein_HttpBodyPartRetraining_6_Tests {

    @testSetup
    static void setup() {
        // Since the class does not interact with any SObjects, there's no need to create test data.
    }

    // Test for happy path when a valid learning rate is set
    @isTest
    static void testGetLearningRateWithValidValue() {
        Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining('modelId', 10, 0.001, null);
        Decimal expectedLearningRate = 0.001;
        Decimal actualLearningRate = bodyPart.getLearningRate();
        System.assertEquals(expectedLearningRate, actualLearningRate, 'The learning rate should match the set value.');
    }

    // Test for sad path when learning rate is not set
    @isTest
    static void testGetLearningRateWhenNotSet() {
        Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining('modelId', 10, null, null);
        Decimal actualLearningRate = bodyPart.getLearningRate();
        System.assert(actualLearningRate == null, 'The learning rate should be null when not set.');
    }

    // Test for exceptional scenario when learning rate is too small
    @isTest
    static void testSetLearningRateTooSmall() {
        try {
            new Einstein_HttpBodyPartRetraining('modelId', 10, 0.00001, null);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Einstein_NumberTooSmallException e) {
            System.assert(true, 'Expected Einstein_NumberTooSmallException to be thrown');
        }
    }

    // Test for exceptional scenario when learning rate is too large
    @isTest
    static void testSetLearningRateTooLarge() {
        try {
            new Einstein_HttpBodyPartRetraining('modelId', 10, 0.02, null);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Einstein_NumberTooBigException e) {
            System.assert(true, 'Expected Einstein_NumberTooBigException to be thrown');
        }
    }
}
