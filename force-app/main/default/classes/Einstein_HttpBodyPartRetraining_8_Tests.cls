
@isTest
public class Einstein_HttpBodyPartRetraining_8_Tests {
    // Since the method getTrainParams is a simple getter, 
    // We don't need to use @testSetup or disable triggers for this test.

    @isTest
    static void testGetTrainParamsWithNonNullValue() {
        // Arrange
        Einstein_TrainParams expectedTrainParams = new Einstein_TrainParams();
        // Setting up a dummy modelId, epochs, and learningRate for the test instance
        String modelId = 'testModelId';
        Integer epochs = 10;
        Decimal learningRate = 0.001;
        
        Einstein_HttpBodyPartRetraining retrainingPart = 
            new Einstein_HttpBodyPartRetraining(modelId, epochs, learningRate, expectedTrainParams);
        
        // Act
        Einstein_TrainParams actualTrainParams = retrainingPart.getTrainParams();
        
        // Assert
        System.assertNotEquals(null, actualTrainParams, 'The trainParams should not be null');
        System.assertEquals(expectedTrainParams, actualTrainParams, 'The trainParams should match the expected value');
    }

    @isTest
    static void testGetTrainParamsWithNullValue() {
        // Arrange
        // Setting up a dummy modelId, epochs, and learningRate for the test instance
        String modelId = 'testModelId';
        Integer epochs = 10;
        Decimal learningRate = 0.001;
        
        Einstein_HttpBodyPartRetraining retrainingPart = 
            new Einstein_HttpBodyPartRetraining(modelId, epochs, learningRate, null);
        
        // Act
        Einstein_TrainParams actualTrainParams = retrainingPart.getTrainParams();
        
        // Assert
        System.assertEquals(null, actualTrainParams, 'The trainParams should be null');
    }
}
