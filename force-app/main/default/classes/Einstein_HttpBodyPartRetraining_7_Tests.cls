
@isTest
private class Einstein_HttpBodyPartRetraining_7_Tests {

    private static final Decimal MIN_LEARNING_RATE = 0.0001;
    private static final Decimal MAX_LEARNING_RAGE = 0.01;

    @isTest
    static void testSetValidLearningRate() {
        Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining('model123', 10, 0.001, null);
        bodyPart.setLearningRate(0.005);

        System.assertEquals(0.005, bodyPart.getLearningRate(), 'The learning rate should be set to the expected value.');
        System.assertTrue(bodyPart.hasLearningRate, 'The hasLearningRate flag should be true.');
    }

    @isTest
    static void testSetLearningRateToNull() {
        Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining('model123', 10, 0.001, null);
        bodyPart.setLearningRate(null);

        System.assertEquals(null, bodyPart.getLearningRate(), 'The learning rate should be null.');
        System.assertFalse(bodyPart.hasLearningRate, 'The hasLearningRate flag should be false.');
    }

    @isTest
    static void testSetLearningRateTooSmall() {
        Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining('model123', 10, 0.001, null);
        Decimal tooSmallRate = MIN_LEARNING_RATE / 2;
        Boolean exceptionThrown = false;
        
        Test.startTest();
        try {
            bodyPart.setLearningRate(tooSmallRate);
        } catch (Einstein_NumberTooSmallException e) {
            exceptionThrown = true;
            // Asserts about the exception details would go here
        }
        Test.stopTest();

        System.assertTrue(exceptionThrown, 'An exception should have been thrown for setting a learning rate too small.');
    }

    @isTest
    static void testSetLearningRateTooBig() {
        Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining('model123', 10, 0.001, null);
        Decimal tooBigRate = MAX_LEARNING_RAGE * 2;
        Boolean exceptionThrown = false;
        
        Test.startTest();
        try {
            bodyPart.setLearningRate(tooBigRate);
        } catch (Einstein_NumberTooBigException e) {
            exceptionThrown = true;
            // Asserts about the exception details would go here
        }
        Test.stopTest();

        System.assertTrue(exceptionThrown, 'An exception should have been thrown for setting a learning rate too big.');
    }
}
