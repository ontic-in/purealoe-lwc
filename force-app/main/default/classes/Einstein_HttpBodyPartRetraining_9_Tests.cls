
@isTest
public class Einstein_HttpBodyPartRetraining_9_Tests {
    // Since we are only testing the setTrainParams method,
    // we don't actually need @testSetup or to bypass triggers in this test class.
    
    // This method will test the happy path scenario where we
    // set the trainParams with a non-null Einstein_TrainParams object.
    @isTest
    static void testSetTrainParamsWithNonNullValue() {
        // Arrange
        Einstein_TrainParams trainParams = new Einstein_TrainParams(); // assuming constructor with no parameters
        Einstein_HttpBodyPartRetraining retraining = 
            new Einstein_HttpBodyPartRetraining('modelId', 10, 0.0005, null);

        // Act
        retraining.setTrainParams(trainParams);

        // Assert
        System.assertEquals(trainParams, retraining.getTrainParams(), 
            'The trainParams should be set correctly when a non-null value is passed.');
    }
    
    // This method will test the scenario where we set the trainParams with null.
    @isTest
    static void testSetTrainParamsWithNullValue() {
        // Arrange
        Einstein_HttpBodyPartRetraining retraining = 
            new Einstein_HttpBodyPartRetraining('modelId', 10, 0.0005, new Einstein_TrainParams());

        // Act
        retraining.setTrainParams(null);

        // Assert
        System.assertEquals(null, retraining.getTrainParams(), 
            'The trainParams should be null when set with a null value.');
    }
}
