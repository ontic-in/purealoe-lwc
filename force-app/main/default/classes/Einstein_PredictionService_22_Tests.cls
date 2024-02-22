
@isTest
private class Einstein_PredictionService_22_Tests {

    private class EinsteinPredictionResultMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake HTTP response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            // Mock a successful prediction response
            String mockResponseBody = '{"probabilities":[{"label":"positive","probability":0.9}]}';
            res.setBody(mockResponseBody);
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testPredictSentimentHappyPath() {
        // Set the mock callout class
        Test.setMock(HttpCalloutMock.class, new EinsteinPredictionResultMock());

        // Instantiate the service with a fake token for testing
        Einstein_PredictionService service = new Einstein_PredictionService('FAKE_ACCESS_TOKEN', Einstein_PredictionService.Types.SENTIMENT);

        // Start the test context
        Test.startTest();
        Einstein_PredictionResult result = service.predictSentiment('MODEL_ID', 'Positive text', 3, 'SAMPLE_ID');
        Test.stopTest();

        // Asserts
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertNotEquals(null, result.probabilities, 'Probabilities should not be null');
        System.assertEquals('positive', result.probabilities[0].label, 'The predicted label should be positive');
    }

    // ... additional test methods ...

}
