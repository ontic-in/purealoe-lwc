
@isTest
private class Einstein_PlaygroundController_11_Tests {

    @testSetup
    static void setup() {
        // Implement test data setup here if needed
    }

    @isTest
    static void testValidateEinsteinPlatformSetup_EinsteinEmailNull() {
        // Disable/bypass triggers for DML operations
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Test when Einstein email is null
        Einstein_Settings__c settings = new Einstein_Settings__c(Einstein_EMail__c = null);
        insert settings;

        Map<String, Boolean> result = Einstein_PlaygroundController.validateEinsteinPlatformSetup();

        System.assertEquals(false, result.get('einsteinEmail'));
        System.assertEquals(false, result.get('einsteinFile'));
    }

    @isTest
    static void testValidateEinsteinPlatformSetup_EinsteinEmailNotNull_EinsteinFileExists() {
        // Disable/bypass triggers for DML operations
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Test when Einstein email is not null and einstein_file exists
        Einstein_Settings__c settings = new Einstein_Settings__c(Einstein_EMail__c = 'test@example.com');
        insert settings;

        // Create a ContentVersion record with Title as 'einstein_platform'
        ContentVersion base64Content = new ContentVersion(
            Title = 'einstein_platform',
            PathOnClient = 'TestPath',
            VersionData = Blob.valueOf('Test Data')
        );
        insert base64Content;

        Map<String, Boolean> result = Einstein_PlaygroundController.validateEinsteinPlatformSetup();

        System.assertEquals(true, result.get('einsteinEmail'));
        System.assertEquals(true, result.get('einsteinFile'));
    }

    @isTest
    static void testValidateEinsteinPlatformSetup_EinsteinEmailNotNull_EinsteinFileDoesNotExist() {
        // Disable/bypass triggers for DML operations
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Test when Einstein email is not null but einstein_file does not exist
        Einstein_Settings__c settings = new Einstein_Settings__c(Einstein_EMail__c = 'test@example.com');
        insert settings;

        Map<String, Boolean> result = Einstein_PlaygroundController.validateEinsteinPlatformSetup();

        System.assertEquals(true, result.get('einsteinEmail'));
        System.assertEquals(false, result.get('einsteinFile'));
    }
}
