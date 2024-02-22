
@isTest
private class Einstein_PredictionService_17_Tests {
    
    @testSetup
    static void setup() {
        // Setup code if needed
    }
    
    @isTest
    static void testGetModelLearningCurveWithValidModelId() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        String validModelId = '12345';
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        
        Einstein_ModelLearningCurve[] learningCurves = service.getModelLearningCurve(validModelId);
        
        System.assertNotEquals(null, learningCurves, 'The returned learning curves should not be null.');
        System.assertTrue(learningCurves.size() > 0, 'The returned learning curves should have data.');
    }
    
    @isTest
    static void testGetModelLearningCurveWithNullModelId() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        String nullModelId = null;
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        
        Test.startTest();
        Exception caughtException = null;
        try {
            service.getModelLearningCurve(nullModelId);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();
        
        System.assertNotEquals(null, caughtException, 'An exception should be thrown for null model ID.');
    }
    
    @isTest
    static void testGetModelLearningCurveWithInvalidModelId() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        String invalidModelId = 'invalidId';
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        
        Test.startTest();
        Exception caughtException = null;
        try {
            service.getModelLearningCurve(invalidModelId);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();
        
        System.assertNotEquals(null, caughtException, 'An exception should be thrown for invalid model ID.');
    }
    
    @isTest
    static void testGetModelLearningCurveWithNoData() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        String modelIdNoData = '12345NoData';
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        
        Einstein_ModelLearningCurve[] learningCurves = service.getModelLearningCurve(modelIdNoData);
        
        System.assertNotEquals(null, learningCurves, 'The returned learning curves should not be null.');
        System.assertEquals(0, learningCurves.size(), 'The returned learning curves should be empty.');
    }
    
    @isTest
    static void testGetModelLearningCurveApiCallFailure() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        String modelIdApiFailure = '12345ApiFailure';
        Einstein_PredictionService service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        
        Test.startTest();
        Exception caughtException = null;
        try {
            service.getModelLearningCurve(modelIdApiFailure);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();
        
        System.assertNotEquals(null, caughtException, 'An exception should be thrown for an API call failure.');
    }
}
