
@isTest
private class Einstein_PredictionService_5_Tests {

    // Implement the HttpCalloutMock interface to simulate the API call
    private class MockHttpCallout implements HttpCalloutMock {
        private String responseBody;
        private Integer statusCode;
        private Boolean isError;
        
        public MockHttpCallout(String responseBody, Integer statusCode, Boolean isError) {
            this.responseBody = responseBody;
            this.statusCode = statusCode;
            this.isError = isError;
        }
        
        // This method is called when the test method executes a callout
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(responseBody);
            res.setStatusCode(statusCode);
            return res;
        }
    }

    // Test method for successful retrieval of datasets
    @isTest
    static void testGetDatasetsSuccess() {
        // Create a JSON response for the mock callout
        String jsonResponse = '[{"id":1,"name":"Dataset 1"},{"id":2,"name":"Dataset 2"}]';
        
        // Set the mock callout with a 200 success response
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout(jsonResponse, 200, false));
        
        // Call the method under test
        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService('validToken', Einstein_PredictionService.Types.IMAGE);
        Einstein_Dataset[] datasets = service.getDatasets();
        Test.stopTest();
        
        // Perform the assertions
        System.assertNotEquals(null, datasets, 'Datasets should not be null');
        System.assertEquals(2, datasets.size(), 'Number of datasets should be 2');
    }

    // Test method for failed retrieval of datasets
    @isTest
    static void testGetDatasetsApiError() {
        // Create an error response for the mock callout
        String errorResponse = '{"message":"Internal Server Error"}';
        
        // Set the mock callout with a 500 error response
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout(errorResponse, 500, true));
        
        // Call the method under test
        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService('validToken', Einstein_PredictionService.Types.IMAGE);
        Einstein_Dataset[] datasets = service.getDatasets();
        Test.stopTest();
        
        // Perform the assertions for error scenario
        System.assertEquals(null, datasets, 'Datasets should be null on API error');
    }

    // Test for exceptional scenario is not applicable because the getAccessToken() method is static 
    // and can't be directly tested via a test method. It should be covered by higher level integration tests.
}
