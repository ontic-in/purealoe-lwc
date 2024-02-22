
@isTest
private class Einstein_HttpBodyPart_8_Tests {
    
    // As no DML operations are performed in the tested method,
    // there is no need to bypass triggers using TriggerHandler.bypass.
    
    private static String base64Decode(String base64Encoded) {
        Blob decodedBlob = EncodingUtil.base64Decode(base64Encoded);
        return decodedBlob.toString();
    }

    @isTest
    static void testWriteBlobBodyParameterHappyPath() {
        // Arrange
        String key = 'file';
        String file64 = EncodingUtil.base64Encode(Blob.valueOf('Test Content'));
        String fileName = 'test.png';
        
        // Act
        String resultEncoded = Einstein_HttpBodyPart.WriteBlobBodyParameter(key, file64, fileName);
        String result = base64Decode(resultEncoded);

        // Assert
        System.assertNotEquals(null, result);
        System.assert(result.contains('Content-Disposition: form-data; name="file"; filename="test.png"'), 'Content-Disposition not found in result');
    }

    @isTest
    static void testWriteBlobBodyParameterUnrecognizedExtension() {
        // Arrange
        String key = 'file';
        String file64 = EncodingUtil.base64Encode(Blob.valueOf('Test Content'));
        String fileName = 'test.unknown';
        
        // Act
        String resultEncoded = Einstein_HttpBodyPart.WriteBlobBodyParameter(key, file64, fileName);
        String result = base64Decode(resultEncoded);

        // Assert
        System.assertNotEquals(null, result);
        System.assert(result.contains('Content-Type: image/png'), 'Fallback MIME type should be used');
    }

    // Additional test methods should also decode the base64 result before asserting
    // ...
}
