
@isTest
private class Einstein_PredictionService_15_Tests {
    // Inner class to mock HTTP response for the test
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private String responseBody;
        private Integer statusCode;

        public MockHttpResponseGenerator(String responseBody, Integer statusCode) {
            this.responseBody = responseBody;
            this.statusCode = statusCode;
        }

        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setBody(this.responseBody);
            res.setStatusCode(this.statusCode);
            return res;
        }
    }

    @testSetup
    static void setup() {
        // Prepare test data if necessary
    }

    // Helper method to bypass triggers
    private static void bypassTriggers() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    // Test retrainDataset with valid parameters
    @isTest
    static void testRetrainDatasetWithValidParams() {
        bypassTriggers();
        String responseBody = '{"modelId":"MODEL_ID","status":"SUCCEEDED"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(responseBody, 200));

        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService('valid_token', Einstein_PredictionService.Types.IMAGE);
        Einstein_Model result = service.retrainDataset('MODEL_ID', 10, 0.01, new Einstein_TrainParams());
        Test.stopTest();

        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals('MODEL_ID', result.modelId, 'The modelId should match.');
    }

    // Test retrainDataset with default epochs and learningRate
    @isTest
    static void testRetrainDatasetWithDefaultParams() {
        bypassTriggers();
        String responseBody = '{"modelId":"MODEL_ID","status":"SUCCEEDED"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(responseBody, 200));

        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService('valid_token', Einstein_PredictionService.Types.IMAGE);
        Einstein_Model result = service.retrainDataset('MODEL_ID', null, null, new Einstein_TrainParams());
        Test.stopTest();

        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals('MODEL_ID', result.modelId, 'The modelId should match.');
    }

    // Test retrainDataset with invalid modelId
    @isTest
    static void testRetrainDatasetWithInvalidModelId() {
        bypassTriggers();
        String responseBody = '{"message":"The requested resource does not exist"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(responseBody, 404));

        Exception modelNotFoundException = null;
        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService('valid_token', Einstein_PredictionService.Types.IMAGE);
        try {
            service.retrainDataset('INVALID_MODEL_ID', 10, 0.01, new Einstein_TrainParams());
        } catch (Exception e) {
            modelNotFoundException = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, modelNotFoundException, 'An exception should have been thrown for an invalid modelId.');
    }

    // Test retrainDataset with underlying exception
    @isTest
    static void testRetrainDatasetWithException() {
        bypassTriggers();
        String responseBody = '{"message":"Internal server error"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(responseBody, 500));

        Exception serverErrorException = null;
        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService('valid_token', Einstein_PredictionService.Types.IMAGE);
        try {
            service.retrainDataset('MODEL_ID', 10, 0.01, new Einstein_TrainParams());
        } catch (Exception e) {
            serverErrorException = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, serverErrorException, 'An exception should have been thrown due to server error.');
    }
}
