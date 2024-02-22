
@isTest
private class Einstein_PredictionService_6_Tests {

    // Helper method to bypass triggers
    private static void bypassTriggers() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    // Happy path scenario
    @isTest
    static void testGetDatasetsHappyPath() {
        bypassTriggers();
        
        // Create instance of service class with valid enum type
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);

        // Call the method we're testing
        Einstein_Dataset[] datasets = service.getDatasets(10, 0, Einstein_PredictionService.Types.IMAGE);

        // Perform assertions
        System.assertNotEquals(null, datasets, 'The result should not be null.');
        System.assertTrue(datasets.size() > 0, 'There should be one or more datasets returned.');
    }

    // Empty result scenario
    @isTest
    static void testGetDatasetsEmptyResult() {
        bypassTriggers();
        
        // Create instance of service class with valid enum type
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);

        // Call the method we're testing
        Einstein_Dataset[] datasets = service.getDatasets(10, 9999, Einstein_PredictionService.Types.IMAGE);

        // Perform assertions
        System.assertNotEquals(null, datasets, 'The result should not be null.');
        System.assertEquals(0, datasets.size(), 'There should be no datasets returned.');
    }

    // More tests would follow...
}
