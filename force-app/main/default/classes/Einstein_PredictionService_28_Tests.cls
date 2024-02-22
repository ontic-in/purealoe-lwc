
@isTest
private class Einstein_PredictionService_28_Tests {

    // Test setup creates shared test records
    @testSetup
    static void setup() {
        // No specific setup required for this test as we're mocking the responses
        // Normally, you might create test data here
    }

    // Helper method to create a mocked response for the HTTP callout
    private static void mockHttpResponse(String body, Integer statusCode) {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(body, statusCode));
    }
    
    // Happy path scenario test
    @isTest
    static void testPredictImageUrl_HappyPath() {
        // Arrange
        String modelId = 'testModelId';
        String imageUrl = 'https://example.com/image.jpg';
        Integer numResults = 1;
        String sampleId = 'testSampleId';
        String responseBody = '{"probabilities":[{"label":"testLabel","probability":0.95}]}';
        
        mockHttpResponse(responseBody, 200);

        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        
        // Act
        Einstein_PredictionResult result = service.predictImageUrl(modelId, imageUrl, numResults, sampleId);
        
        // Assert
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals('testLabel', result.probabilities[0].label, 'Label should match');
    }
    
    // Sad path scenario test
    @isTest
    static void testPredictImageUrl_SadPath() {
        // Arrange
        String modelId = 'incorrectModelId';
        String imageUrl = 'https://example.com/image.jpg';
        Integer numResults = 1;
        String sampleId = 'testSampleId';
        String responseBody = '{"message":"Model ID not found"}';
        
        mockHttpResponse(responseBody, 400);

        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        
        // Act
        Einstein_PredictionResult result = service.predictImageUrl(modelId, imageUrl, numResults, sampleId);
        
        // Assert
        System.assertEquals(null, result, 'Result should be null on failure');
        System.assertEquals(400, service.httpStatusCode, 'HTTP status code should be 400');
    }
    
    // Exceptional scenario test
    @isTest
    static void testPredictImageUrl_Exceptional() {
        // Test for exception handling, e.g., null parameters
        
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        String expectedErrorMessage = 'Required parameters must not be null';
        
        // Act & Assert
        try {
            service.predictImageUrl(null, null, null, null);
            System.assert(false, 'Method should have thrown an exception when required parameters are null');
        } catch (Exception e) {
            System.assert(e.getMessage().contains(expectedErrorMessage), 'Exception message should contain expected error message');
        }
    }
    
    // MockHttpResponse inner class to simulate HTTP response
    private class MockHttpResponse implements HttpCalloutMock {
        private String responseBody;
        private Integer statusCode;
        
        public MockHttpResponse(String responseBody, Integer statusCode) {
            this.responseBody = responseBody;
            this.statusCode = statusCode;
        }
        
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            response.setBody(responseBody);
            response.setStatusCode(statusCode);
            return response;
        }
    }
}
