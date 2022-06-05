@isTest
public with sharing class ExerciseDBCalloutTest {
  @isTest
  private static void testExerciseDBEndpoint() {
    Test.setMock(HttpCalloutMock.class, new ExerciseDBMockResponseGenerator());

    Test.startTest();
    Object res = ExerciseDBCallout.getAllExercises();
    System.assertEquals('["arm", "legs"]', res, 'response mismatch');
    res = ExerciseDBCallout.getBodyParts();
    System.assertEquals('["arm", "legs"]', res, 'response mismatch');
    res = ExerciseDBCallout.getTargetMuscles();
    System.assertEquals('["arm", "legs"]', res, 'response mismatch');
    Test.stopTest();
  }

  @isTest
  private static void testCache() {
    Test.setMock(HttpCalloutMock.class, new ExerciseDBMockResponseGenerator());

    Test.startTest();
    Object res = ExerciseDBCallout.getAllExercises();
    System.assertEquals('["arm", "legs"]', res, 'response mismatch');
    System.assertEquals(
      '["arm", "legs"]',
      Cache.Session.get('exercises'),
      'Cache not filled'
    );
    System.assertEquals(1, Limits.getCallouts(), 'Callouts made != 1');
    res = ExerciseDBCallout.getAllExercises();
    System.assertEquals(1, Limits.getCallouts(), 'Callouts made != 1');
    Test.stopTest();
  }
}
