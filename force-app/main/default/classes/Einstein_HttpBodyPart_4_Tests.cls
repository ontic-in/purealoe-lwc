
@isTest
private class Einstein_HttpBodyPart_4_Tests {

    // Test method for verifying that WriteBoundary() returns a correctly formatted base64 string
    @isTest
    static void testWriteBoundary() {
        // Arrange (no setup needed for this test as the method has no input parameters)
        
        // Act
        String result = Einstein_HttpBodyPart.WriteBoundary();
        
        // Assert
        System.assertNotEquals(null, result, 'The result should not be null');
        String expectedStart = '--' + Einstein_HttpBodyPart.getBoundary() + '\r\n';
        Blob expectedBlob = Blob.valueOf(expectedStart);
        String expectedBase64 = EncodingUtil.base64Encode(expectedBlob);
        System.assertEquals(expectedBase64, result, 'The base64-encoded boundary should match the expected value');
    }
}
