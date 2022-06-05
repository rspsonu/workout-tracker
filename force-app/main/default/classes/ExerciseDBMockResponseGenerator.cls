@isTest
public with sharing class ExerciseDBMockResponseGenerator implements HttpCalloutMock {
  public HTTPResponse respond(HTTPRequest req) {
    HttpResponse res = new HttpResponse();
    res.setBody('["arm", "legs"]');
    res.setStatusCode(200);
    return res;
  }
}
