
@isTest
private class Einstein_PredictionService_33_Tests {

    @testSetup
    static void setup() {
        Einstein_Settings__c settings = new Einstein_Settings__c(Einstein_EMail__c = 'test@example.com');
        insert settings;

        // We will not insert a ContentVersion here as we will mock the response in the test
        // ContentVersion base64Content = new ContentVersion(
        //     Title = 'einstein_platform',
        //     VersionData = Blob.valueOf('Base64EncodedCertificate'),
        //     PathOnClient = 'einstein_platform.pem'
        // );
        // insert base64Content;
    }

    @isTest
    static void testGetBearerTokenHappyPath() {
        Test.startTest();
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.SENTIMENT);
        String token = service.getBearerToken();
        Test.stopTest();

        System.assertNotEquals(null, token, 'The bearer token should not be null.');
        System.assertNotEquals('', token, 'The bearer token should not be an empty string.');
    }

    @isTest
    static void testGetBearerTokenMissingEmail() {
        delete [SELECT Id FROM Einstein_Settings__c];

        Exception caughtException;
        Test.startTest();
        try {
            Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.SENTIMENT);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();

        System.assert(caughtException != null, 'An exception should have been thrown due to missing email settings.');
        System.assert(caughtException instanceof Einstein_ConfigurationException, 'The thrown exception should be an Einstein_ConfigurationException.');
        System.assertEquals('Missing Einstein email setting. Check your Custom Settings.', caughtException.getMessage(), 'The exception message should match the expected error message.');
    }

    @isTest
    static void testGetBearerTokenCertificateNotFound() {
        // Simulate the certificate not being found by not inserting it in the setup method
        Exception caughtException;
        Test.startTest();
        try {
            Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.SENTIMENT);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();

        System.assert(caughtException != null, 'An exception should have been thrown due to missing certificate.');
        System.assert(caughtException instanceof Einstein_ConfigurationException, 'The thrown exception should be an Einstein_ConfigurationException.');
        System.assert(caughtException.getMessage().contains('Could not retrieve the Einstein Platform certificate file'), 'The exception message should inform about missing Einstein Platform certificate file.');
    }
}
