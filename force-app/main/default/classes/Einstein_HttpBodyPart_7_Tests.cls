
@isTest
private class Einstein_HttpBodyPart_7_Tests {
    
    // ... other test methods ...

    @isTest
    static void testWriteBodyParameterWithEmptyKey() {
        String key = '';
        String value = 'testValue';
        
        String result = Einstein_HttpBodyPart.WriteBodyParameter(key, value);
        String decodedResult = EncodingUtil.base64Decode(result).toString();
        
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assert(decodedResult.contains('name=""'), 'The result should contain an empty key.');
    }
    
    // ... other test methods ...
}
