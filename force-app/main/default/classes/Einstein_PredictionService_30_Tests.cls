
@isTest
public class Einstein_PredictionService_30_Tests {

    @testSetup
    static void setup() {
        // Setup test data if required
    }

    @isTest
    static void testIsExecutingWhenTrue() {
        // Setup
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        service.isExecuting(true);

        // Execute
        Boolean result = service.isExecuting();

        // Verify
        System.assertEquals(true, result, 'Expected isExecuting to return true.');
    }

    @isTest
    static void testIsExecutingWhenFalse() {
        // Setup
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        service.isExecuting(false);

        // Execute
        Boolean result = service.isExecuting();

        // Verify
        System.assertEquals(false, result, 'Expected isExecuting to return false.');
    }
}
