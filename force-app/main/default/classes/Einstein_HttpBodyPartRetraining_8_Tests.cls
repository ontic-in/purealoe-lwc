
@isTest
private class Einstein_HttpBodyPartRetraining_8_Tests {

    @testSetup
    static void setupTestData() {
        // Create test data if needed
    }

    @isTest
    static void testGetTrainParamsWhenTrainParamsNotNull() {
        // Arrange
        Einstein_TrainParams trainParams = new Einstein_TrainParams();
        // Act
        Einstein_HttpBodyPartRetraining obj = new Einstein_HttpBodyPartRetraining('modelId', 5, 0.0005, trainParams);
        // Assert
        System.assertEquals(trainParams, obj.getTrainParams());
    }

    @isTest
    static void testGetTrainParamsWhenTrainParamsNull() {
        // Arrange
        Einstein_HttpBodyPartRetraining obj = new Einstein_HttpBodyPartRetraining('modelId', 5, 0.0005, null);
        // Act & Assert
        System.assertEquals(null, obj.getTrainParams());
    }

    @isTest
    static void testGetTrainParamsExceptionThrown() {
        // Arrange
        Boolean isExceptionThrown = false;
        try {
            // Act
            Einstein_HttpBodyPartRetraining obj = new Einstein_HttpBodyPartRetraining('modelId', 101, 0.0005, null);
        } catch (Einstein_NumberTooBigException ex) {
            // Assert
            isExceptionThrown = true;
        }
        System.assert(isExceptionThrown);
    }
}
