
@isTest
private class Einstein_PredictionService_7_Tests {

    @testSetup
    static void setup() {
        // Common test data setup, if required.
    }

    @isTest
    static void testDeleteDataset_Successful() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Instantiate the service with a dummy typeEnum
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);

        // Execute: Call the method to test
        Boolean result = service.deleteDataset(1L); // Replace with an actual datasetId that should be successfully deleted

        // Verify: Assert that the result is true
        System.assertEquals(true, result, 'The dataset should be deleted successfully.');
    }

    @isTest
    static void testDeleteDataset_InvalidId() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Instantiate the service with a dummy typeEnum
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);

        // Execute: Call the method to test and expect an exception
        Boolean didThrowCorrectException = false;
        try {
            service.deleteDataset(0L);
        } catch (Einstein_NoValuesException e) {
            didThrowCorrectException = true;
        }

        // Verify: Assert that the exception was thrown
        System.assertTrue(didThrowCorrectException, 'An Einstein_NoValuesException should be thrown for an invalid dataset ID.');
    }

    @isTest
    static void testDeleteDataset_Failure() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Instantiate the service with a dummy typeEnum
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);

        // Execute: Call the method to test
        Boolean result = service.deleteDataset(2L); // Replace with an actual datasetId that should fail to be deleted

        // Verify: Assert that the result is false
        System.assertEquals(false, result, 'The dataset deletion should fail.');
    }
}
