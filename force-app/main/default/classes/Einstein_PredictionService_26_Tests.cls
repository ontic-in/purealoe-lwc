
@isTest
private class Einstein_PredictionService_26_Tests {

    // Helper method to simulate a valid mock response for the prediction
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);

            // Simulate a possible JSON response from the prediction API
            String body = '{"probabilities": [{"label": "testLabel", "probability": 0.95}]}';
            res.setBody(body);

            return res;
        }
    }

    @testSetup
    static void setup() {
        // Create test data if necessary
        // Since we're mocking responses, we may not need actual data here
    }

    @isTest
    static void testPredictImageBase64HappyPath() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Arrange
        String validModelId = 'validModelId';
        String validBase64 = 'validBase64String';
        Integer validNumResults = 3;
        String validSampleId = 'sample123';
        
        // Mock response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Act
        Einstein_PredictionService.Types predictionType = Einstein_PredictionService.Types.IMAGE;
        Einstein_PredictionService predictionService = new Einstein_PredictionService(predictionType);
        Einstein_PredictionResult result = predictionService.detectImageBase64(validModelId, validBase64, validNumResults, validSampleId);

        // Assert
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(1, result.probabilities.size(), 'Should have 1 probability in the result');
        System.assertEquals('testLabel', result.probabilities[0].label, 'Label should match mock response');
        System.assertEquals(0.95, result.probabilities[0].probability, 'Probability should match mock response');
    }

    // Implement the rest of the test methods similarly, with appropriate mock responses for each scenario
    // ...

}
