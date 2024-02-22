
@isTest
private class Einstein_HttpBodyPartRetraining_5_Tests {

    @testSetup
    static void setupTestData() {
        // Create any required test data here
    }

    @isTest
    static void testSetEpochsHappyPath() {
        // Happy Path Test
        Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining(
            'sampleModelId',
            50,
            0.001,
            new Einstein_TrainParams()
        );

        // Verify that epochs are set correctly
        System.assertEquals(50, bodyPart.getEpochs());
    }

    @isTest
    static void testSetEpochsInvalidValue() {
        // Sad Path Test - Invalid Value
        Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining(
            'sampleModelId',
            0,
            0.001,
            new Einstein_TrainParams()
        );

        // Verify that hasEpochs flag is set to false
        System.assertEquals('0', String.valueOf(bodyPart.getEpochs()));
    }

    @isTest
    static void testSetEpochsOutOfRange() {
        // Sad Path Test - Out of Range
        try {
            Einstein_HttpBodyPartRetraining bodyPart = new Einstein_HttpBodyPartRetraining(
                'sampleModelId',
                150,
                0.001,
                new Einstein_TrainParams()
            );
            // If no exception is thrown, the test should fail
            System.assert(false, 'Exception should have been thrown for epochs out of range');
        } catch (Einstein_NumberTooBigException e) {
            // Verify that the exception message contains the field name and invalid value
            System.assert(e.getMessage().contains('epochs'));
            System.assert(e.getMessage().contains('150'));
        } catch (Exception ex) {
            System.assert(false, 'Unexpected exception type: ' + ex.getTypeName());
        }
    }
}
