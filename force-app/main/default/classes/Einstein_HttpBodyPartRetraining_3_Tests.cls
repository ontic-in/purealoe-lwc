
@isTest
public class Einstein_HttpBodyPartRetraining_3_Tests {

    // Test data setup method
    @testSetup
    static void setup() {
        // No specific setup required for testing setModelId method.
    }

    // Happy Path
    @isTest
    static void shouldSetModelIdWhenValid() {
        Einstein_HttpBodyPartRetraining retrainingInstance = new Einstein_HttpBodyPartRetraining('model123', 1, 0.0001, null);

        retrainingInstance.setModelId('validModelId');
        String actualModelId = retrainingInstance.getModelId();

        System.assertEquals('validModelId', actualModelId, 'The modelId should be set correctly when a valid modelId is provided.');
    }

    // Sad Path
    @isTest
    static void shouldThrowExceptionWhenModelIdIsEmpty() {
        Einstein_HttpBodyPartRetraining retrainingInstance = new Einstein_HttpBodyPartRetraining('model123', 1, 0.0001, null);
        Exception caughtException;
        
        try {
            retrainingInstance.setModelId('');
        } catch (Einstein_StringIsEmptyException e) {
            caughtException = e;
        }

        System.assertNotEquals(null, caughtException, 'An exception should have been thrown when an empty modelId is set.');
        System.assertEquals('modelId', caughtException.getMessage(), 'The exception message should match the expected message for an empty modelId.');
    }
}
