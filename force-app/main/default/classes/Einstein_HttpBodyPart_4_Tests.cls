
@isTest
private class Einstein_HttpBodyPart_4_Tests {

    @isTest
    static void testWriteBoundaryWithoutEndingType() {
        // Test writing the boundary without any ending type
        String expectedBoundary = '--1ff13444ed8140c7a32fc4e6451aa76d\r\n';
        String actualBoundary = EncodingUtil.base64Decode(Einstein_HttpBodyPart.WriteBoundary()).toString();
        System.assertEquals(expectedBoundary, actualBoundary, 'Boundary should be written without any ending type');
    }

    @isTest
    static void testWriteBoundaryWithCR() {
        // Test writing the boundary with an ending type of CR
        String expectedBoundary = '\n--1ff13444ed8140c7a32fc4e6451aa76d--';
        String actualBoundary = EncodingUtil.base64Decode(Einstein_HttpBodyPart.WriteBoundary(Einstein_HttpBodyPart.EndingType.Cr)).toString();
        System.assertEquals(expectedBoundary, actualBoundary, 'Boundary should be written with an ending type of CR');
    }

    @isTest
    static void testWriteBoundaryWithCRLF() {
        // Test writing the boundary with an ending type of CRLF
        String expectedBoundary = '\r\n--1ff13444ed8140c7a32fc4e6451aa76d--';
        String actualBoundary = EncodingUtil.base64Decode(Einstein_HttpBodyPart.WriteBoundary(Einstein_HttpBodyPart.EndingType.CrLf)).toString();
        System.assertEquals(expectedBoundary, actualBoundary, 'Boundary should be written with an ending type of CRLF');
    }

    @isTest
    static void testWriteBoundaryWithInvalidEndingType() {
        // Test writing the boundary with an invalid ending type
        String expectedBoundary = '--1ff13444ed8140c7a32fc4e6451aa76d--';
        String actualBoundary = EncodingUtil.base64Decode(Einstein_HttpBodyPart.WriteBoundary(Einstein_HttpBodyPart.EndingType.None)).toString();
        System.assertEquals(expectedBoundary, actualBoundary, 'Boundary should be written with an ending type of None');
    }
}
