
@isTest
private class Einstein_HttpBodyPart_3_Tests {

    @isTest
    static void testSafelyPad_HappyPath() {
        String value = 'TestValue';
        String valueCrLf64 = EncodingUtil.base64Encode(Blob.valueOf('TestValue\r\n'));
        String lineBreaks = '\r\n';
        
        String paddedValue = Einstein_HttpBodyPart.SafelyPad(value, valueCrLf64, lineBreaks);
        // Assert that the padded value is not equal to the original base64 value
        System.assertNotEquals(valueCrLf64, paddedValue, 'Value should have been padded');
    }

    @isTest
    static void testSafelyPad_SadPath_EmptyValue() {
        String value = '';
        String valueCrLf64 = '';
        String lineBreaks = '\r\n';
        
        String paddedValue = Einstein_HttpBodyPart.SafelyPad(value, valueCrLf64, lineBreaks);
        // Assert that the padded value is equal to the original base64 value (no padding)
        System.assertEquals(valueCrLf64, paddedValue, 'Value should not have been padded');
    }

    @isTest
    static void testSafelyPad_ExceptionalScenario_AlreadyPadded() {
        String value = 'TestValue';
        // Create a base64 encoded string with padding
        String valueCrLf64 = EncodingUtil.base64Encode(Blob.valueOf('TestValue\r\n')) + '=='; 
        String lineBreaks = '\r\n';
        
        String paddedValue = Einstein_HttpBodyPart.SafelyPad(value, valueCrLf64, lineBreaks);
        // Assert that the padded value is not equal to the original base64 value
        System.assertNotEquals(valueCrLf64, paddedValue, 'Value should not have been further padded as it is already padded');
    }
}
