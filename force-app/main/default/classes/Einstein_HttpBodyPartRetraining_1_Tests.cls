
@isTest
private class Einstein_HttpBodyPartRetraining_1_Tests {
    @testSetup
    static void setupTestData() {
        // Create test data setup here
    }
    
    @isTest
    static void testBuildWithAllParameters() {
        // Test the public Blob build() method with all parameters set
        Einstein_HttpBodyPartRetraining part = new Einstein_HttpBodyPartRetraining('modelId', 10, 0.001, new Einstein_TrainParams());
        Blob bodyBlob = part.build();
        System.assertNotEquals(null, bodyBlob, 'Body Blob should not be null');
        // Add more assertions if needed
    }
    
    @isTest
    static void testBuildWithoutEpochs() {
        // Test the public Blob build() method without epochs
        Einstein_HttpBodyPartRetraining part = new Einstein_HttpBodyPartRetraining('modelId', null, 0.001, new Einstein_TrainParams());
        Blob bodyBlob = part.build();
        System.assertNotEquals(null, bodyBlob, 'Body Blob should not be null');
        // Add more assertions if needed
    }
    
    @isTest
    static void testBuildWithoutLearningRate() {
        // Test the public Blob build() method without learning rate
        Einstein_HttpBodyPartRetraining part = new Einstein_HttpBodyPartRetraining('modelId', 10, null, new Einstein_TrainParams());
        Blob bodyBlob = part.build();
        System.assertNotEquals(null, bodyBlob, 'Body Blob should not be null');
        // Add more assertions if needed
    }
    
    @isTest
    static void testBuildWithTrainParamsNull() {
        // Test the public Blob build() method with trainParams as null
        Einstein_HttpBodyPartRetraining part = new Einstein_HttpBodyPartRetraining('modelId', 10, 0.001, null);
        Blob bodyBlob = part.build();
        System.assertNotEquals(null, bodyBlob, 'Body Blob should not be null');
        // Add more assertions if needed
    }
}
