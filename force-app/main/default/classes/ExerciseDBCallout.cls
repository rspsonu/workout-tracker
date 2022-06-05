public with sharing class ExerciseDBCallout {
  private static Object makeCallout(String params) {
    List<String> paramBlocks = params.split('/');
    String key = paramBlocks[paramBlocks.size() - 1];
    if (Cache.Session.contains(key)) {
      return Cache.Session.get(key);
    }
    HttpRequest req = new HttpRequest();
    req.setMethod('GET');
    req.setEndpoint('callout:ExerciseDB' + params);
    req.setHeader('X-RapidAPI-Host', 'exercisedb.p.rapidapi.com');
    req.setHeader('X-RapidAPI-Key', '{!$Credential.Password}');
    HttpResponse res = new Http().send(req);
    Cache.Session.put(key, res.getBody());
    return res.getBody();
  }

  @AuraEnabled
  public static Object getBodyParts() {
    return makeCallout('/exercises/bodyPartList');
  }

  @AuraEnabled
  public static Object getTargetMuscles() {
    return makeCallout('/exercises/targetList');
  }

  @AuraEnabled
  public static Object getAllExercises() {
    return makeCallout('/exercises');
  }
}
