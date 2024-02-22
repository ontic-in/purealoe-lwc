
@isTest
public class Einstein_PredictionService_21_Tests {
    
    private static final String VALID_MODEL_ID = 'validModelId';
    private static final String VALID_TEXT = 'Sample text to predict intent';
    private static final Integer VALID_NUM_RESULTS = 3;
    private static final String VALID_SAMPLE_ID = 'sampleId123';
    
    private class MockHttpCallout implements HttpCalloutMock {
        protected Integer statusCode;
        protected String responseBody;

        public MockHttpCallout(Integer statusCode, String responseBody) {
            this.statusCode = statusCode;
            this.responseBody = responseBody;
        }

        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(this.statusCode);
            response.setBody(this.responseBody);
            return response;
        }
    }

    @testSetup
    static void setup() {
        // Since we're mocking external calls, no test data setup is necessary in this case.
    }

    @isTest
    static void testPredictIntentHappyPath() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Set up mock response for the callout
        String responseBody = '{"probabilities":[{"label":"intentLabel", "probability":0.95}]}';
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout(200, responseBody));
        
        // Act
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.INTENT);
        Einstein_PredictionResult result = service.predictIntent(VALID_MODEL_ID, VALID_TEXT, VALID_NUM_RESULTS, VALID_SAMPLE_ID);
        
        // Assert
        System.assertNotEquals(null, result, 'The prediction result should not be null.');
        System.assertEquals('intentLabel', result.probabilities[0].label, 'The predicted intent label should match.');
    }

    @isTest
    static void testPredictIntentInvalidModelId() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Set up mock response for the callout
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout(200, '{}'));
        
        // Act
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.INTENT);
        Einstein_PredictionResult result = service.predictIntent('', VALID_TEXT, VALID_NUM_RESULTS, VALID_SAMPLE_ID);
        
        // Assert
        System.assertEquals(null, result, 'The prediction result should be null for invalid modelId.');
    }

    @isTest
    static void testPredictIntentServiceUnavailable() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Set up mock response for the callout simulating service unavailability
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout(503, 'Service Unavailable'));
        
        // Act
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.INTENT);
        Einstein_PredictionResult result = null;
        try {
            result = service.predictIntent(VALID_MODEL_ID, VALID_TEXT, VALID_NUM_RESULTS, VALID_SAMPLE_ID);
            System.assert(false, 'An exception should have been thrown due to service unavailability.');
        } catch (Exception e) {
            // Assert exception thrown
            System.assertNotEquals(null, e, 'An exception should have been thrown due to service unavailability.');
        }
        
        // Assert result is still null
        System.assertEquals(null, result, 'The prediction result should be null when the service is unavailable.');
    }
}
