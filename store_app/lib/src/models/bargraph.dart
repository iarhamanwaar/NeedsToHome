
class BarGraphModel {
  int month;
  double instance;
  double schedule;



  BarGraphModel();

  BarGraphModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      month = jsonMap['month'];
      instance = jsonMap['instance'].toDouble();
      schedule = jsonMap['schedule'].toDouble();


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["month"] = month;
    map["instance"] = instance;
    map["schedule"] = schedule;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();

    return map.toString();
  }
}
