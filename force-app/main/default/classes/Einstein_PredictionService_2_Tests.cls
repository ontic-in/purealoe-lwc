
@isTest
private class Einstein_PredictionService_2_Tests {

    // Mock class for simulating HTTP callouts
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private String responseBody;
        private Integer statusCode;
        
        public MockHttpResponseGenerator(String responseBody, Integer statusCode) {
            this.responseBody = responseBody;
            this.statusCode = statusCode;
        }
        
        public HTTPResponse respond(HTTPRequest request) {
            HTTPResponse response = new HTTPResponse();
            response.setBody(responseBody);
            response.setStatusCode(statusCode);
            return response;
        }
    }

    @testSetup
    static void setup() {
        // Setup test data if necessary. Not required for this test as we are focusing on external service call simulation.
    }
    
    private static Einstein_PredictionService.Types validTypeEnum = Einstein_PredictionService.Types.IMAGE;
    
    /**
     * Simulates a successful dataset creation from a URL.
     */
    @isTest
    static void testCreateDatasetFromUrlSync_Success() {
        // Disable Account triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        String mockUrl = 'https://example.com/mockImageUrl';
        String mockResponse = '{"id": 123456789, "status": "SUCCEEDED"}';

        // Mocking HTTP callout response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockResponse, 200));
        
        Einstein_PredictionService service = new Einstein_PredictionService(validTypeEnum);
        Test.startTest();
        Einstein_Dataset resultDataset = service.createDatasetFromUrlSync(mockUrl);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, resultDataset, 'The result should not be null.');
        System.assertEquals(new Long(123456789), resultDataset.id, 'The id should match the mocked response.');
    }

    /**
     * Simulates a failure in dataset creation due to a bad request (e.g., invalid URL).
     */
    @isTest
    static void testCreateDatasetFromUrlSync_Failure() {
        // Disable Account triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        String invalidUrl = 'invalidUrl';
        String mockErrorResponse = '{"message": "Bad Request"}';

        // Mocking HTTP callout response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockErrorResponse, 400));
        
        Einstein_PredictionService service = new Einstein_PredictionService(validTypeEnum);
        Test.startTest();
        Einstein_Dataset resultDataset = service.createDatasetFromUrlSync(invalidUrl);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, resultDataset, 'The result should be null for an invalid request.');
        System.assertEquals(400, service.httpStatusCode, 'The HTTP status code should be 400 for a bad request.');
    }
    
    // Additional test methods can be added here if necessary.
}
