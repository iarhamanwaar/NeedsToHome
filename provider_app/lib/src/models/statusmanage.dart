

class Statusmanage {
  String type;
  String time;

  Statusmanage();

  Statusmanage.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      type = jsonMap['type'].toString();
      time = jsonMap['time'] != null ? jsonMap['time'].toString() : null;
    } catch (e) {
      type = '';
      time = '';
      print(e);
    }
  }



  Map toMap() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    map["time"] = time;

    return map;
  }


}
