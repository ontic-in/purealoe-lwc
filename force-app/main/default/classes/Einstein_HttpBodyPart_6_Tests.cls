
@isTest
private class Einstein_HttpBodyPart_6_Tests {

    @testSetup
    static void setupTestData() {
        // Add any setup required for the test
    }

    @isTest
    static void testWriteBodyParameter_ValidKeyAndValue() {
        // Test writing body parameter for valid key and value
        String key = 'TestKey';
        Integer value = 10;
        
        Test.startTest();
        String bodyParameter = Einstein_HttpBodyPart.WriteBodyParameter(key, value);
        Test.stopTest();

        System.assertNotEquals(null, bodyParameter, 'Body parameter should not be null');
        System.assertNotEquals('', bodyParameter, 'Body parameter should not be empty');
        System.assert(bodyParameter.contains(key), 'Body parameter should contain the key');
        System.assert(bodyParameter.contains(String.valueOf(value)), 'Body parameter should contain the value');
    }

    @isTest
    static void testWriteBodyParameter_NullKey() {
        // Test writing body parameter for null key
        Integer value = 10;
        
        Test.startTest();
        String bodyParameter = Einstein_HttpBodyPart.WriteBodyParameter('TestKey', value);
        Test.stopTest();

        System.assertEquals('', bodyParameter, 'Body parameter should be empty for null key');
    }

    @isTest
    static void testWriteBodyParameter_NullValue() {
        // Test writing body parameter for null value
        String key = 'TestKey';
        
        Test.startTest();
        String bodyParameter = Einstein_HttpBodyPart.WriteBodyParameter(key, (Integer)null);
        Test.stopTest();

        System.assertEquals('', bodyParameter, 'Body parameter should be empty for null value');
    }

    @isTest
    static void testWriteBodyParameter_NegativeValue() {
        // Test writing body parameter for negative value
        String key = 'TestKey';
        Integer value = -10;
        
        Test.startTest();
        String bodyParameter = Einstein_HttpBodyPart.WriteBodyParameter(key, value);
        Test.stopTest();

        System.assertNotEquals(null, bodyParameter, 'Body parameter should not be null for negative value');
        System.assertNotEquals('', bodyParameter, 'Body parameter should not be empty for negative value');
        System.assert(bodyParameter.contains(key), 'Body parameter should contain the key for negative value');
        System.assert(bodyParameter.contains(String.valueOf(value)), 'Body parameter should contain the value for negative value');
    }
}
