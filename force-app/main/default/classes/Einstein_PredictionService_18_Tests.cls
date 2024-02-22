
@isTest
private class Einstein_PredictionService_18_Tests {
    
    @testSetup
    static void setup() {
        // Test setup is not strictly needed as we're mocking external service calls,
        // but it's here if needed for future test methods.
    }
    
    @isTest
    static void testGetModelMetrics_SuccessfulResponse() {
        // Bypass triggers as specified
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Mock the HTTP callout
        Test.setMock(HttpCalloutMock.class, new Einstein_PredictionServiceMock_Success());
        
        // Instantiate the service
        Einstein_PredictionService service = new Einstein_PredictionService('dummyToken', Einstein_PredictionService.Types.IMAGE);
        
        // Execute the method to test
        Test.startTest();
        Einstein_ModelMetrics modelMetrics = service.getModelMetrics('validModelId');
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, modelMetrics, 'ModelMetrics should not be null');
    }
    
    @isTest
    static void testGetModelMetrics_NotFoundResponse() {
        // Bypass triggers as specified
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Mock the HTTP callout
        Test.setMock(HttpCalloutMock.class, new Einstein_PredictionServiceMock_NotFound());
        
        // Instantiate the service
        Einstein_PredictionService service = new Einstein_PredictionService('dummyToken', Einstein_PredictionService.Types.IMAGE);
        
        // Execute the method to test
        Test.startTest();
        Einstein_ModelMetrics modelMetrics = service.getModelMetrics('invalidModelId');
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, modelMetrics, 'ModelMetrics should be null for an invalid modelId');
        System.assertEquals(404, service.httpStatusCode, 'HTTP status code should be 404 for not found');
    }
    
    @isTest
    static void testGetModelMetrics_EmptyModelId() {
        // Bypass triggers as specified
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Instantiate the service
        Einstein_PredictionService service = new Einstein_PredictionService('dummyToken', Einstein_PredictionService.Types.IMAGE);
        
        // Test for null modelId
        Boolean exceptionThrown = false;
        Test.startTest();
        try {
            service.getModelMetrics(null); // Passing null to simulate empty modelId scenario
        } catch (Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();
        // Assertions
        System.assert(exceptionThrown, 'An exception should be thrown when the modelId is null');

        // Test for empty modelId
        exceptionThrown = false;
        try {
            service.getModelMetrics(''); // Passing empty string to simulate empty modelId scenario
        } catch (Exception e) {
            exceptionThrown = true;
        }
        // Assertions
        System.assert(exceptionThrown, 'An exception should be thrown when the modelId is empty');
    }
}
