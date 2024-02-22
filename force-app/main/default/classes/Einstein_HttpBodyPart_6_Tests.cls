
@isTest
private class Einstein_HttpBodyPart_6_Tests {

    // Rest of the test methods remain unchanged...

    @isTest
    static void testWriteBodyParameterWithLargeIntegerValue() {
        String key = 'testKey';
        Integer value = 2147483647; // A large integer value
        
        String result = Einstein_HttpBodyPart.WriteBodyParameter(key, value);
        
        // Assertions
        System.assertNotEquals(null, result, 'The result should not be null.');
        
        // Instead of asserting that the result contains the exact large integer value,
        // we should check that the result is a correctly encoded base64 string
        // which indirectly contains our large integer value.
        Blob decodedBlob = EncodingUtil.base64Decode(result);
        String decodedString = decodedBlob.toString();
        System.assert(decodedString.contains(key), 'The decoded result should contain the key.');
        System.assert(decodedString.contains(String.valueOf(value)), 'The decoded result should contain the string representation of the large integer value.');
    }
}
