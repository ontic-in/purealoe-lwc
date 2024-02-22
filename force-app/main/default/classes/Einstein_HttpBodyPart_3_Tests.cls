
@isTest
private class Einstein_HttpBodyPart_3_Tests {

    // Since we're testing a static method that doesn't interact with the database,
    // we don't need a @testSetup method here.
    
    // Happy path scenario where padding is needed
    @isTest
    static void testSafelyPadWithPadding() {
        // Given
        String value = 'TestString';
        String lineBreaks = '\r\n';
        
        // When
        String result = Einstein_HttpBodyPart.SafelyPad(value, value + lineBreaks, lineBreaks);
        
        // Then
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(false, result.endsWith('='), 'Result should not end with padding character.');
    }
    
    // Happy path scenario where no padding is needed
    @isTest
    static void testSafelyPadWithoutPadding() {
        // Given
        String value = 'TestStringWithNoPaddingNeeded';
        String lineBreaks = '\r\n';
        
        // Pre-encode to ensure no padding is needed
        blob valueCrLfBlob = blob.valueOf(value + lineBreaks);
        String valueCrLf64 = EncodingUtil.base64Encode(valueCrLfBlob);
        
        // When
        String result = Einstein_HttpBodyPart.SafelyPad(value, valueCrLf64, lineBreaks);
        
        // Then
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(false, result.endsWith('='), 'Result should not end with padding character.');
    }
    
    // Sad path scenario with null value
    @isTest
    static void testSafelyPadWithNullValue() {
        // Given
        String value = null;
        String lineBreaks = '\r\n';
        
        // When
        String result = Einstein_HttpBodyPart.SafelyPad(value, '', lineBreaks);
        
        // Then
        System.assertEquals('', result, 'The result should be an empty string.');
    }
    
    // Sad path with empty strings
    @isTest
    static void testSafelyPadWithEmptyStrings() {
        // Given
        String value = '';
        String lineBreaks = '';
        
        // When
        String result = Einstein_HttpBodyPart.SafelyPad(value, '', lineBreaks);
        
        // Then
        System.assertEquals('', result, 'The result should be an empty string.');
    }
    
    // Exceptional scenario with long string
    @isTest
    static void testSafelyPadWithLongString() {
        // Given
        String value = 'LongString'.repeat(1000); // Generate a very long string
        String lineBreaks = '\r\n';
        
        // When
        String result = Einstein_HttpBodyPart.SafelyPad(value, value + lineBreaks, lineBreaks);
        
        // Then
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(false, result.endsWith('='), 'Result should not end with padding character.');
    }
}
