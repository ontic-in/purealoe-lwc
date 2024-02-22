
@isTest
private class Einstein_PredictionService_19_Tests {

    @testSetup
    static void setup() {
        // Test setup code goes here
    }

    @isTest
    static void testGetModelsHappyPath() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Mock external service call here
        // ...

        // Assuming we have a valid datasetId for the happy path
        Long validDatasetId = 1L;

        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        Einstein_Model[] models = service.getModels(validDatasetId);
        Test.stopTest();

        // Perform assertions
        System.assertNotEquals(null, models, 'The models should not be null');
        System.assert(models.size() > 0, 'The models array should not be empty');
    }

    @isTest
    static void testGetModelsSadPath() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Mock external service call here
        // ...

        // Assuming we have an invalid datasetId for the sad path
        Long invalidDatasetId = 9999L;

        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        Einstein_Model[] models = service.getModels(invalidDatasetId);
        Test.stopTest();

        // Perform assertions
        System.assertEquals(null, models, 'The models should be null when an error is returned from the service');
    }

    @isTest
    static void testGetModelsExceptionalScenario() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // No need to mock external service call here as an exception is expected before the callout

        // Test for an exception when the datasetId is 0
        Long zeroDatasetId = 0L;
        Boolean didThrowException = false;

        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        try {
            service.getModels(zeroDatasetId);
        } catch (Einstein_NoValuesException e) {
            didThrowException = true;
        }
        Test.stopTest();
        
        // Assertions
        System.assert(didThrowException, 'An Einstein_NoValuesException should have been thrown');
    }
}
