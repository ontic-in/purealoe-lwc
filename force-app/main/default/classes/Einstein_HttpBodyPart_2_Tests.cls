
@isTest
private class Einstein_HttpBodyPart_2_Tests {

    // Since we do not have any DML operations in the GetContentType method, we do not need to bypass any triggers. 
    // However, I will demonstrate how to do it if needed for other test methods
    // TriggerHandler.bypass('AccountTriggerHandler');
    // TriggerHandler.bypass('MDTAccountTriggerHandler');

    @isTest
    static void testGetContentTypeHappyPath() {
        // Expected content type format
        String expectedContentType = 'multipart/form-data; charset="UTF-8"; boundary="1ff13444ed8140c7a32fc4e6451aa76d"';
        
        // Execute the method to test
        String actualContentType = Einstein_HttpBodyPart.GetContentType();

        // Assertions
        System.assertEquals(expectedContentType, actualContentType, 'The content type should match the expected format with boundary.');
    }
}
