class TimeZone{
  String id;
  String name;

  TimeZone();
  TimeZone.fromJSON(Map<String, dynamic> jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'] : '';
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
    }
    catch(e){
      print(e);
    }
  }
}