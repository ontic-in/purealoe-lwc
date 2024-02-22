
@isTest
public class Einstein_PlaygroundController_11_Tests {
    // Create a default Einstein_Settings__c record
    private static void createEinsteinSettings(Boolean withEmail) {
        Einstein_Settings__c settings = new Einstein_Settings__c();
        if (withEmail) {
            settings.Einstein_Email__c = 'test@example.com';
        }
        insert settings;
    }
    
    // Create a ContentVersion record for the happy path
    private static void createContentVersion() {
        ContentVersion einsteinPlatformContent = new ContentVersion(
            Title = 'einstein_platform',
            VersionData = Blob.valueOf('Test Data'),
            PathOnClient = 'einstein_platform.txt'
        );
        insert einsteinPlatformContent;
    }

    @testSetup
    static void setup() {
        createEinsteinSettings(true); // with email
        createContentVersion();       // with content version
    }
    
    @isTest
    static void testValidateSetupHappyPath() {
        // Bypass triggers are not needed for this test as no DML operation occurs on trigger-enabled objects

        // Call the method to test
        Map<String, Boolean> validationResult = Einstein_PlaygroundController.validateEinsteinPlatformSetup();

        // Assert that both settings are true
        System.assertEquals(true, validationResult.get('einsteinEmail'), 'The einsteinEmail should be true.');
        System.assertEquals(true, validationResult.get('einsteinFile'), 'The einsteinFile should be true.');
    }
    
    @isTest
    static void testValidateSetupSadPath() {
        // In the @testSetup we already created settings with an email, now let's update it to simulate the sad path
        Einstein_Settings__c settings = [SELECT Id FROM Einstein_Settings__c LIMIT 1];
        settings.Einstein_Email__c = null; // Simulate the absence of an email setting
        update settings;
        
        // Bypass triggers are not needed for this test as no DML operation occurs on trigger-enabled objects

        // Call the method to test
        Map<String, Boolean> validationResult = Einstein_PlaygroundController.validateEinsteinPlatformSetup();

        // Assert that the email setting is false and file setting is true (since we cannot delete the content version in test)
        System.assertEquals(false, validationResult.get('einsteinEmail'), 'The einsteinEmail should be false.');
        System.assertEquals(true, validationResult.get('einsteinFile'), 'The einsteinFile should still be true as we did not delete the content version.');
    }
}
