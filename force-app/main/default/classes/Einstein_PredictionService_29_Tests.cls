
@isTest
private class Einstein_PredictionServiceMock implements HttpCalloutMock {
    private String responseJson;
    private Integer statusCode;

    public Einstein_PredictionServiceMock(String responseJson, Integer statusCode) {
        this.responseJson = responseJson;
        this.statusCode = statusCode;
    }

    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setBody(responseJson);
        response.setStatusCode(statusCode);
        return response;
    }
}

@isTest
private class Einstein_PredictionService_29_Tests {

    @testSetup
    static void makeTestData() {
        // Test setup data can be created here, if needed
    }

    private static void prepareMock(String responseJson, Integer statusCode) {
        // Prepare HttpCalloutMock to simulate API responses
        Test.setMock(HttpCalloutMock.class, new Einstein_PredictionServiceMock(responseJson, statusCode));
    }

    private static Einstein_PredictionService instantiateService() {
        // Instantiate the service with a dummy token and ENUM type for testing
        return new Einstein_PredictionService('dummy_bearer_token', Einstein_PredictionService.Types.IMAGE);
    }

    @isTest
    static void testGetApiUsageSuccess() {
        // Assuming a successful API response
        String successfulResponse = '[{"label":"API Calls","description":"API Calls this hour","used":10,"remaining":990}]';
        prepareMock(successfulResponse, 200);
        Einstein_PredictionService service = instantiateService();

        Test.startTest();
        Einstein_ApiUsage[] apiUsage = service.getApiUsage();
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, apiUsage, 'The apiUsage should not be null');
        System.assertEquals(1, apiUsage.size(), 'There should be one API Usage object');
    }

    @isTest
    static void testGetApiUsageFailure() {
        // Assuming an unsuccessful API response
        String errorResponse = 'API limit exceeded';
        prepareMock(errorResponse, 429); // 429 Too Many Requests
        Einstein_PredictionService service = instantiateService();

        Test.startTest();
        Einstein_ApiUsage[] apiUsage = service.getApiUsage();
        Test.stopTest();

        // Assertions
        System.assertEquals(null, apiUsage, 'The apiUsage should be null');
        System.assertEquals(429, service.httpStatusCode, 'The status code should be 429');
    }
}
