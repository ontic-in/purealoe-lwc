
@isTest
private class Einstein_PredictionService_34_Tests {

    @testSetup
    static void setup() {
        // Create Einstein email setting
        Einstein_Settings__c settings = new Einstein_Settings__c(
            Name = 'Default',
            Einstein_EMail__c = 'test@example.com'
        );
        insert settings;

        // Insert a dummy ContentVersion record for the certificate
        ContentVersion cert = new ContentVersion(
            Title = 'einstein_platform',
            VersionData = Blob.valueOf('Dummy RSA key data'),
            PathOnClient = 'einstein_platform.pem'
        );
        insert cert;
    }

    @isTest
    static void testGetAccessTokenHappyPath() {
        Test.setMock(HttpCalloutMock.class, new Einstein_PredictionServiceMock('{"access_token":"dummy_access_token","token_type":"Bearer"}', 200));
        
        Test.startTest();
        String accessToken = Einstein_PredictionService.getAccessToken();
        Test.stopTest();

        System.assertNotEquals(null, accessToken, 'Access token should not be null.');
        System.assert(accessToken.startsWith('Bearer'), 'Access token should start with Bearer.');
    }

    @isTest
    static void testGetAccessTokenMissingEmail() {
        // Update the Einstein email setting to simulate missing email
        Einstein_Settings__c setting = [SELECT Id, Einstein_EMail__c FROM Einstein_Settings__c LIMIT 1];
        setting.Einstein_EMail__c = null;
        update setting;

        Boolean exceptionThrown = false;
        try {
            Test.startTest();
            String accessToken = Einstein_PredictionService.getAccessToken();
            Test.stopTest();
        } catch (Einstein_ConfigurationException e) {
            exceptionThrown = true;
        }

        System.assert(exceptionThrown, 'Missing Einstein email should throw a configuration exception.');
    }

    // Note: This test method is for illustration purposes only. In a real-world scenario,
    //       you would need to design your code to handle certificate presence verification differently.
    @isTest(expectedExceptions = Einstein_ConfigurationException.class)
    static void testGetAccessTokenMissingCertificate() {
        // Manually remove the certificate from the setup data
        delete [SELECT Id FROM ContentVersion WHERE Title = 'einstein_platform' LIMIT 1];
        
        Test.startTest();
        String accessToken = Einstein_PredictionService.getAccessToken();
        Test.stopTest();
        
        // If the method does not throw an exception, the test will fail
    }
}
