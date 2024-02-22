
@isTest
private class Einstein_HttpBodyPart_5_Tests {

    @isTest
    static void testWriteBoundaryWithCrEnding() {
        // Arrange
        String expectedBase64BoundaryStart = EncodingUtil.base64Encode(Blob.valueOf('\n--1ff13444ed8140c7a32fc4e6451aa76d--'));
        
        // Act
        String resultBoundary = Einstein_HttpBodyPart.WriteBoundary(Einstein_HttpBodyPart.EndingType.Cr);
        
        // Assert
        System.assertEquals(expectedBase64BoundaryStart, resultBoundary, 'Boundary with CR ending did not match expected value.');
    }

    @isTest
    static void testWriteBoundaryWithNoneEnding() {
        // Arrange
        String expectedBase64BoundaryStart = EncodingUtil.base64Encode(Blob.valueOf('\r\n--1ff13444ed8140c7a32fc4e6451aa76d--'));
        
        // Act
        String resultBoundary = Einstein_HttpBodyPart.WriteBoundary(Einstein_HttpBodyPart.EndingType.None);
        
        // Assert
        System.assertEquals(expectedBase64BoundaryStart, resultBoundary, 'Boundary with None ending did not match expected value.');
    }

    @isTest
    static void testWriteBoundaryWithCrLfEnding() {
        // Arrange
        String expectedBase64BoundaryStart = EncodingUtil.base64Encode(Blob.valueOf('--1ff13444ed8140c7a32fc4e6451aa76d--'));
        
        // Act
        String resultBoundary = Einstein_HttpBodyPart.WriteBoundary(Einstein_HttpBodyPart.EndingType.CrLf);
        
        // Assert
        System.assertEquals(expectedBase64BoundaryStart, resultBoundary, 'Boundary with CrLf ending did not match expected value.');
    }

    @isTest
    static void testWriteBoundaryWithNullEnding() {
        // Arrange
        String expectedBase64BoundaryStart = EncodingUtil.base64Encode(Blob.valueOf('--1ff13444ed8140c7a32fc4e6451aa76d--'));
        
        // Act
        String resultBoundary = Einstein_HttpBodyPart.WriteBoundary(null);
        
        // Assert
        System.assertEquals(expectedBase64BoundaryStart, resultBoundary, 'Boundary with null ending did not match expected value.');
    }
}
